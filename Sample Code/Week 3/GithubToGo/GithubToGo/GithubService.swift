//
//  GithubService.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/13/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation


class GithubService {
  
  static let sharedInstance : GithubService = GithubService()
  
  let githubSearchRepoURL = "https://api.github.com/search/repositories"
  
  let localURL = "http://127.0.0.1:3000"
  
  func fetchReposForSearch(searchTerm : String, completionHandler : ( [Repository]?, String?) ->(Void)) {
    
    let queryString = "?q=\(searchTerm)"
    let requestURL = githubSearchRepoURL + queryString
    let url = NSURL(string: requestURL)
    let request = NSMutableURLRequest(URL: url!)
    
    if let token = NSUserDefaults.standardUserDefaults().objectForKey("githubToken") as? String {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      
      if let httpResponse = response as? NSHTTPURLResponse {
        println(httpResponse.statusCode)
        
        if httpResponse.statusCode == 200 {
          
          let repos = RepoJSONParser.reposFromJSONData(data)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(repos,nil)
          })
        }
      }
      //this is our callback
    })
    dataTask.resume()
  }
  
  func fetchUsersForSearch(search : String, completionHandler : ([User]?, String?) -> (Void)) {
    
    let searchURL = "https://api.github.com/search/users?q="
    let url = searchURL + search
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    
    if let token = NSUserDefaults.standardUserDefaults().objectForKey("githubToken") as? String {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      
      let users = UserJSONParser.usersFromJSONData(data)
      
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        println("hi")
        completionHandler(users,nil)
      })
      
//      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//        
//        completionHandler(users, nil)
//      })
    })
    dataTask.resume()
    
    
    
    
    
    
  }
}
