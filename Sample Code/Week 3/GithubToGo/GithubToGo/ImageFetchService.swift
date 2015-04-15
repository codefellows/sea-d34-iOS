//
//  ImageFetchService.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit


class ImageFetchService {
  
  let imageQueue = NSOperationQueue()
  
  func fetchImageForURL(url : String, completionHandler : (UIImage?) -> (Void)) {
    self.imageQueue.addOperationWithBlock { () -> Void in
      if let imageData = NSData(contentsOfURL: NSURL(string: url)!) {
        let image = UIImage(data: imageData)
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(image)
        })
      }
    }
  }
}