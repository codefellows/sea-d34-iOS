//
//  TimelineViewController.swift
//  ImageFilters
//
//  Created by Bradley Johnson on 4/7/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let query = PFQuery(className: "Post")
      query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
        if error != nil {
          println(error.localizedDescription)
        } else {
          println(results.count)
          
        }
      }

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
