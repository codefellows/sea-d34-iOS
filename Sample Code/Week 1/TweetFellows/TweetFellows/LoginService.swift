//
//  LoginService.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/31/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
  

  class func requestTwitterAccount(completionHandler : (ACAccount?, String?) ->Void) {
    
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if granted && error == nil  {
        if let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
          
          if !accounts.isEmpty {
            let twitterAccount = accounts.first
            completionHandler(twitterAccount,nil)
          }
        }
        
      } else {
        if error != nil {
          println(error.code)
        }
      completionHandler(nil,"Please sign in to your twitter account")
      }
    }
 
  }
}
