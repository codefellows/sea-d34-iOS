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
  
  class var sharedService : TwitterService {
    struct Static {
      static let instance : TwitterService = TwitterService()
    }
    return Static.instance
  }
  
  var twitterAccount : ACAccount?
  let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  let tweetInfoURL = "https://api.twitter.com/1.1/statuses/show.json?id="
  
  init() {
    //left blank
  }
  
  func fetchHomeTimeline(completionHandler : ([Tweet]?,String?)-> ()){
    
    let requestURL  = NSURL(string: homeTimelineURL)
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    
    twitterRequest.performRequestWithHandler { (data, response, error) in
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
  
  func fetchInfoForTweet(id : String, completionHandler : (String?) -> Void) {
    
    let tweetInfoURL = self.tweetInfoURL + id
    let requestURL  = NSURL(string: tweetInfoURL)
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = twitterAccount
    
    twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
      if response.statusCode == 200 {
        let info = TweetJSONParser.tweetInfoFromJSON(data)
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(info)
        })
      }
    }
    
  }
}
