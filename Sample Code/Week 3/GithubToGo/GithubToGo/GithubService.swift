//
//  GithubService.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/13/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation


class GithubService {
  
  let githubSearchRepoURL = "https://api.github.com/search/repositories"
  
  let localURL = "http://127.0.0.1:3000"
  
  func fetchReposForSearch(searchTerm : String, completionHandler : ( [Repository]?, String?) ->(Void)) {
    
    let queryString = "?q=\(searchTerm)"
    let requestURL = localURL + queryString
    let url = NSURL(string: requestURL)
    let request = NSURLRequest(URL: url!)
    
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
}
