//
//  User.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class User {
  
  let login : String
  let avatarURL : String
  let htmlURL : String
  var avatarImage : UIImage?

  init(login : String, avatarURL : String, htmlURL : String) {
    self.login = login
    self.avatarURL = avatarURL
    self.htmlURL = htmlURL
  }
  
}
