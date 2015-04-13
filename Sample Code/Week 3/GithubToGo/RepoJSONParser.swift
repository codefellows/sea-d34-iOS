//
//  RepoJSONParser.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/13/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation


class RepoJSONParser {
  
  class func reposFromJSONData(jsonData : NSData) -> [Repository] {
    var repos = [Repository]()
    var jsonError : NSError?
    
    if let
      rootDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as? [String : AnyObject],
      repoArray      = rootDictionary["items"] as? [[String : AnyObject]]
    {
      for repoDictionary in repoArray {
        if let
          name = repoDictionary["name"] as? String,
          ownerDictionary = repoDictionary["owner"] as? [String : AnyObject],
          author = ownerDictionary["login"] as? String,
          htmlURL = repoDictionary["html_url"] as? String,
          description = repoDictionary["description"] as? String {
            
            let repo = Repository(name: name, author: author, htmlURL: htmlURL, description: description)
            repos.append(repo)
        }
      }
    }
    return repos
  }
}