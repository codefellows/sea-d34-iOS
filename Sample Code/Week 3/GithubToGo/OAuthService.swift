//
//  OAuthService.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/14/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class OAuthService {
  
  var oauthRequestCompletionHandler : (() -> ())?
  
  func requestOAuth(completionHandler : () -> ()) {
    self.oauthRequestCompletionHandler = completionHandler
      let initialOAuthURL = "https://github.com/login/oauth/authorize?client_id=\(kGithubClientID)&scope=user,public_repo"
    
    
    UIApplication.sharedApplication().openURL(NSURL(string: initialOAuthURL)!)
  }
  
  func handleRedirect(url : NSURL) {
    
    let code = url.query
    
    let url = "https://github.com/login/oauth/access_token"
    
    let parameters = "\(code!)&client_id=\(kGithubClientID)&client_secret=\(kGithubSecret)"
    
      let data = parameters.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
    
    
    
  let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    request.HTTPMethod = "POST"
    request.HTTPBody = data
    
    //Accept: application/json
    request.setValue("application/json", forHTTPHeaderField: "Accept")
  
    request.setValue("\(data!.length)", forHTTPHeaderField: "Content-Length")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      
      if error == nil {
        
        if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String : AnyObject] {
          let token = jsonDictionary["access_token"] as! String
          println(token)
          
          NSUserDefaults.standardUserDefaults().setObject(token, forKey: "githubToken")
          NSUserDefaults.standardUserDefaults().synchronize()
          
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.oauthRequestCompletionHandler!()
          })
          
          
        }
      }
    })
    dataTask.resume()
  
  }
}
