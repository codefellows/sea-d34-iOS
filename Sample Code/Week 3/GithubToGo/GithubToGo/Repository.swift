//
//  Repository.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/13/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation

struct Repository {
  
  var name : String
  var author : String
  var htmlURL : String
  var description : String
  
  
  init(name : String, author : String, htmlURL : String, description : String) {
    self.name = name
    self.author = author
    self.htmlURL = htmlURL
    self.description = description
  }

}
