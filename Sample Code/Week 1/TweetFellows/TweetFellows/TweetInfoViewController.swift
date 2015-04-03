//
//  TweetInfoViewController.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 4/2/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class TweetInfoViewController: UIViewController {
  
  @IBOutlet weak var userButton: UIButton!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  
  var selectedTweet : Tweet!
//  var twitterService : TwitterService!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.usernameLabel.text = self.selectedTweet.username
      self.tweetTextLabel.text = self.selectedTweet.text
      self.userButton.setBackgroundImage(selectedTweet.profileImage, forState: UIControlState.Normal)
      
      TwitterService.sharedService.fetchInfoForTweet(self.selectedTweet.id, completionHandler: { [weak self] (retweets ) -> Void in
        if self != nil {
        self!.retweetCountLabel.text = retweets
        }
      })
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
