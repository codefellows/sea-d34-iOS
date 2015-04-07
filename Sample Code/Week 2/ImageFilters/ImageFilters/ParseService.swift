//
//  ParseService.swift
//  ImageFilters
//
//  Created by Bradley Johnson on 4/7/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation

class ParseService {
  
  class func uploadImage(originalImage : UIImage, size : CGSize, completionHandler : (String?) -> Void) {
    
    let resizedImage = ImageResizer.resizeImage(originalImage, size: size)
    let imageData = UIImageJPEGRepresentation(resizedImage, 1.0)
    let imageFile = PFFile(name: "post.jpg", data: imageData)
    let post = PFObject(className: "Post")
    post["image"] = imageFile
    
    post.saveInBackgroundWithBlock({ (finished, error) -> Void in
      completionHandler(nil)
    })
    
  }
}
