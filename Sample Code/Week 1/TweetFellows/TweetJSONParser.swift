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
        
        if let text = object["text"] as? String {
          //println(text)
          let tweet = Tweet(text: text)
          tweets.append(tweet)
        }
      }
    }
    return tweets
  }
  
}