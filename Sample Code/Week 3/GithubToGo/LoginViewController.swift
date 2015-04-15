//
//  LoginViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/14/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  var imageViewWidth : CGFloat = 200
  var imageViewHeight : CGFloat = 200
  
  var floatingAnimationDuration = 1.3
  var imageViewDropHeight : CGFloat = 7

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight))
      imageView.image = UIImage(named: "github")
      imageView.center = self.view.center
      self.view.addSubview(imageView)
      
      UIView.animateWithDuration(floatingAnimationDuration, delay: 0, options: UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse, animations: { [unowned self] () -> Void in
       //imageView.frame.origin = CGPoint(x: 0, y: 30)
        //imageView.frame.size.width = 300
      imageView.center = CGPoint(x: imageView.center.x, y: imageView.center.y + self.imageViewDropHeight)
      }, completion: nil)
      
//      let redBox = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//      redBox.backgroundColor = UIColor.redColor()
//      self.view.addSubview(redBox)
//      
//      let timeInterval = NSTimeInterval(2)
      
   
      
//      UIView.animateKeyframesWithDuration(2.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.allZeros, animations: { () -> Void in
//        
//        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.25, animations: { () -> Void in
//          redBox.center.y = self.view.center.y
//        })
//        
//        UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.75, animations: { () -> Void in
//          redBox.center.x = 3000.0
//        })
//        
//      }, completion: nil)
    
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
          if finished {
          window?.rootViewController = navigationController
          }
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
