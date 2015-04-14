//
//  LoginViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/14/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  @IBAction func loginPressed(sender: AnyObject) {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let oauthService = appDelegate.oauthService
    
    oauthService.requestOAuth { [weak self] () -> () in
      //transition to main menu if we get token back
      if self != nil {
        
        let window = appDelegate.window
        let navigationController = self?.storyboard?.instantiateViewControllerWithIdentifier("MainMenuNav") as! UINavigationController
        
        UIView.transitionFromView(self!.view, toView: navigationController.view, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { (finished) -> Void in
          window?.rootViewController = navigationController
        })
      }
    }
    
    
   
    
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
