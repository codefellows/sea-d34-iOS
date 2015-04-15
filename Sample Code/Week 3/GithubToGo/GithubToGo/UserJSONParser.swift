//
//  UserJSONParser.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation

class UserJSONParser {
  
  class func usersFromJSONData(data : NSData) -> [User] {
    
    var users = [User]()
    var jsonError : NSError?
    if let
      jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String : AnyObject],
      items = jsonDictionary["items"] as? [[String : AnyObject]] {
        for item in items {
          if let
            login = item["login"] as? String,
            avatarURL = item["avatar_url"] as? String,
            htmlURL = item["html_url"] as? String {
              let user = User(login: login, avatarURL: avatarURL, htmlURL: htmlURL)
              users.append(user)
          }
        }
    }
    return users
  }
}