//
//  TweetJSONParser.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/30/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation

class TweetJSONParser {
  
  class func tweetsFromJSONData(data : NSData) -> [Tweet] {
    
    var tweets = [Tweet]()
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&error) as? [[String : AnyObject]] {
      
      for object in jsonObject {
        
        if let
          text = object["text"] as? String,
          userInfo = object["user"] as? [String : AnyObject],
          id = object["id_str"] as? String,
          username = userInfo["name"] as? String,
          profileImageURL = userInfo["profile_image_url"] as? String
          
        {
          let tweet = Tweet(text: text, username: username, id: id, profileImageURL: profileImageURL)
          tweets.append(tweet)
        }
      }
    }
    return tweets
  }
  
  class func tweetInfoFromJSON(data :NSData) -> String? {
    
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject] {
      if let retweetCount = jsonObject["retweet_count"] as? Int {
        return "\(retweetCount)"
      }
    }
    return nil
  }
  
}