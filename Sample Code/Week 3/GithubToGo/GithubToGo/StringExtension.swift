//
//  StringExtension.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/16/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation


extension String {
  func validForURL()-> Bool {
    
    let elements = count(self)
    let range = NSMakeRange(0,elements)
    let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n]", options: nil, error: nil)
    let matches = regex?.numberOfMatchesInString(self, options: nil, range: range)
    
    if matches > 0 {
      return false
    }
    
    return true
    
  }
}

