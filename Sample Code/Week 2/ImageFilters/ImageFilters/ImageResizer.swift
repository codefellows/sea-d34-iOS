//
//  ImageResizer.swift
//  ImageFilters
//
//  Created by Bradley Johnson on 4/7/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class ImageResizer {
  
  
  class func resizeImage(originalImage : UIImage, size : CGSize) -> UIImage {
    
    UIGraphicsBeginImageContext(size)
    originalImage.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
}
