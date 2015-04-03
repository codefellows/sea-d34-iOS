//
//  HomeTimelineViewController.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/30/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  var myLabel : UILabel!
  
  let imageService = ImageService()
  //let twitterService = TwitterService()
  //rule 1, given a default value inline
  var name = "Brad"
  //rule 2, marked as an optional
  var tweets : [Tweet]?
  //rules 3, the property is given a value in an init
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.navigationController
      self.activityIndicator.startAnimating()
      
      let nib = UINib(nibName: "TweetTableViewCell", bundle: NSBundle.mainBundle())
      self.tableView.registerNib(nib, forCellReuseIdentifier: "TweetCell")
      self.tableView.userInteractionEnabled = false
      self.tableView.estimatedRowHeight = 70
      self.tableView.rowHeight = UITableViewAutomaticDimension
      self.tableView.dataSource = self
      self.tableView.delegate = self
      self.tableView.alpha = 0
  self.navigationController?.hidesBarsOnSwipe = true
      
      UIView.animateWithDuration(2.0, animations: { () -> Void in
        self.tableView.alpha = 1
      })
      
     
      LoginService.requestTwitterAccount { (twitterAccount, errorDescription) -> Void in
        println("got the account!")
        if twitterAccount != nil {
          TwitterService.sharedService.twitterAccount = twitterAccount
          TwitterService.sharedService.fetchHomeTimeline({ (tweets, errorDescription) -> Void in
            if errorDescription != nil {
              //handle an error
            }
            if tweets != nil {
              self.tweets = tweets
              self.tableView.reloadData()
              self.activityIndicator.stopAnimating()
              self.activityIndicator.hidden = true
              self.tableView.userInteractionEnabled = true
            }
          })
          
        }
      }
      
    
      
//      if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
//        
//        if let data = NSData(contentsOfFile: filePath) {
//          self.tweets = TweetJSONParser.tweetsFromJSONData(data)
//          self.tableView.reloadData()
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
    cell.tag++
    let tag = cell.tag
    cell.textLabel?.text = nil //set this to nil because the table view is reusing the cells
    cell.profileImageView.image = nil
    if let tweet = self.tweets?[indexPath.row] {
      cell.tweetTextLabel.text = tweet.text
      cell.usernameLabel.text = tweet.username
      cell.profileImageView.image = tweet.profileImage
      
      if let image = tweet.profileImage {
        cell.profileImageView.image = image
      } else {
        
        self.imageService.fetchProfileImage(tweet.profileImageURL, completionHandler: { [weak self] (image) -> () in
          if self != nil {
          tweet.profileImage = image
          if tag == cell.tag {
          cell.profileImageView.image = tweet.profileImage
          }
          }
        })
        
      }
    }
    cell.layoutIfNeeded()
    return cell
  }

  //MARK:
  //MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("TweetInfoVC") as TweetInfoViewController
    let selectedTweet = self.tweets![indexPath.row]
    viewController.selectedTweet = selectedTweet
    //viewController.twitterService = self.twitterService
    
    self.navigationController?.pushViewController(viewController, animated: true)
  }

  @IBAction func cameraButtonPressed(sender: AnyObject) {
  }
}
