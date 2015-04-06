//
//  FilterService.swift
//  ImageFilters
//
//  Created by Bradley Johnson on 4/6/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit
import CoreImage

class FilterService {
  
  class func sepia(originalImage : UIImage) -> UIImage {
    
    let image = CIImage(image: originalImage)
    let sepia = CIFilter(name: "CIPixellate")
    sepia.setDefaults()
    //sepia.setValue(1.0, forKey: kCIInputIntensityKey)
    sepia.setValue(image, forKey: kCIInputImageKey)
    let result = sepia.valueForKey(kCIOutputImageKey) as CIImage
    
    for input in sepia.inputKeys() {
      println(input)
    }
    
    if "Bradf" == "Brad" {
      
      var brad = "Brad"
      
      
      
    }
    
    let options = [kCIContextWorkingColorSpace : NSNull()]
    let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
    let context = CIContext(EAGLContext: eaglContext, options: options)
    
    let resultRef = context.createCGImage(result, fromRect: result.extent())
    return UIImage(CGImage: resultRef)!
    
    
    
  }
}
