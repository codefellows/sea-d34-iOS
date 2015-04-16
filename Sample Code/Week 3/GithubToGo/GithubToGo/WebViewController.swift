//
//  WebViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/16/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  var selectedRepo : Repository!

  var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let urlRequest = NSURLRequest(URL: NSURL(string: selectedRepo.htmlURL)!)
      self.webView = WKWebView(frame: self.view.frame)
      self.view.addSubview(self.webView)
     self.webView.loadRequest(urlRequest)
      
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
