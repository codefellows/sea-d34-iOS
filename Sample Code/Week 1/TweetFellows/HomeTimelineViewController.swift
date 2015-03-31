//
//  HomeTimelineViewController.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/30/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  var myLabel : UILabel!
  
 
  let twitterService = TwitterService()
  //rule 1, given a default value inline
  var name = "Brad"
  //rule 2, marked as an optional
  var tweets : [Tweet]?
  //rules 3, the property is given a value in an init
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.tableView.dataSource = self
      self.tableView.alpha = 0
      
      UIView.animateWithDuration(2.0, animations: { () -> Void in
        self.tableView.alpha = 1
      })
      
      LoginService.requestTwitterAccount { (twitterAccount, errorDescription) -> Void in
        println("got the account!")
        if twitterAccount != nil {
          self.twitterService.twitterAccount = twitterAccount
          self.twitterService.fetchHomeTimeline({ (tweets, errorDescription) -> Void in
            if errorDescription != nil {
              //handle an error
            }
            if tweets != nil {
              self.tweets = tweets
              self.tableView.reloadData()
            }
          })
          
        }
      }
      
    
      
//      if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
//        
//        if let data = NSData(contentsOfFile: filePath) {
//          self.tweets = TweetJSONParser.tweetsFromJSONData(data)
//          //println(tweets.count)
//        }
//      }
    }
  
  //MARK:
  //MARK: UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.tweets != nil {
      return self.tweets!.count
    }
      return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TweetTableViewCell
    cell.textLabel?.text = nil //set this to nil because the table view is reusing the cells
    if let tweet = self.tweets?[indexPath.row] {
      cell.tweetTextLabel.text = tweet.text
      cell.usernameLabel.text = tweet.username
    }
    return cell
  }


}
