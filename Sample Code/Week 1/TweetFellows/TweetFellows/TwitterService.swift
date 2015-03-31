//
//  TwitterService.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/31/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation
import Social
import Accounts

class TwitterService {
  
  var twitterAccount : ACAccount?
  let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  
  init() {
    //left blank
  }
  
  func fetchHomeTimeline(completionHandler : ([Tweet]?,String?) -> Void){
    
    let requestURL  = NSURL(string: homeTimelineURL)
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    
    twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error != nil {
        //handle error here
      } else {
        var errorDescription : String? = nil
        var tweets = [Tweet]()
        switch response.statusCode {
        case 200...299:
          tweets = TweetJSONParser.tweetsFromJSONData(data)
        case 400...499:
          errorDescription = "Try again"
        case 500...599:
          errorDescription = "Servers are busy"
        default:
          errorDescription = "Please try again"
        }
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(tweets,errorDescription)
        })
       
      }
    }
    
  }
}
