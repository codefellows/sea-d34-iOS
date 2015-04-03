//
//  Tweet.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/30/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class Tweet {
  
  var text : String
  var username : String
  var id : String
  var profileImage : UIImage?
  var profileImageURL : String
  
  init(text : String, username : String, id : String, profileImageURL : String) {
    self.text = text
    self.username = username
    self.id = id
    self.profileImageURL = profileImageURL
  }
  
}
