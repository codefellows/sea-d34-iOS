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
  
  func fetchImageForURL(url : String, imageViewSize : CGSize, completionHandler : (UIImage?) -> (Void)) {
    println(url)
    let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
   
    sessionConfig.URLCache = NSURLCache.sharedURLCache()
    sessionConfig.requestCachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
    
    let session = NSURLSession(configuration: sessionConfig)
    
    let request = NSURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 20.0)
    
    session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      
      let image = UIImage(data: data)
      let resizedImageThumbnail = ImageResizer.resizeImage(image!, size: imageViewSize)
      
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(resizedImageThumbnail)
      })
    }).resume()
//    
//    self.imageQueue.addOperationWithBlock { () -> Void in
//      if let imageData = NSData(contentsOfURL: NSURL(string: url)!) {
//        let image = UIImage(data: imageData)
//        let resizedImageThumbnail = ImageResizer.resizeImage(image!, size: imageViewSize)
//
//          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//          completionHandler(resizedImageThumbnail)
//        })
//      }
//    }
  }
}