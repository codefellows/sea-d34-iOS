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
  
  class func sepia(originalImage : UIImage, context : CIContext) -> UIImage {
    
    let sepia = CIFilter(name: "CISepiaTone")
    return self.filteredImageFromOriginalImage(originalImage, filter: sepia, context: context)
  }
  
  class func colorInvert(originalImage : UIImage, context : CIContext) -> UIImage {
    
    let invert = CIFilter(name: "CIColorInvert")
    invert.setDefaults()

    return self.filteredImageFromOriginalImage(originalImage, filter: invert, context: context)
    
  }
  
  class func instant(originalImage : UIImage, context : CIContext) -> UIImage {
    
  
    let instant = CIFilter(name: "CIPhotoEffectInstant")
    instant.setDefaults()
    
    return self.filteredImageFromOriginalImage(originalImage, filter: instant, context: context)
    
  }
  
  class func chrome(originalImage : UIImage, context : CIContext) -> UIImage {
    let chrome = CIFilter(name: "CIPhotoEffectChrome")
    chrome.setDefaults()
    
    return self.filteredImageFromOriginalImage(originalImage, filter: chrome, context: context)
    
  }
  
  class func noir(originalImage : UIImage, context : CIContext) -> UIImage {
    
    let noir = CIFilter(name: "CIPhotoEffectNoir")
    noir.setDefaults()
    return self.filteredImageFromOriginalImage(originalImage, filter: noir, context: context)
  }
  
  private class func filteredImageFromOriginalImage(originalImage : UIImage, filter : CIFilter, context : CIContext) -> UIImage {
    
    let image = CIImage(image: originalImage)
    filter.setValue(image, forKey: kCIInputImageKey)
    let result = filter.valueForKey(kCIOutputImageKey) as CIImage
    let resultRef = context.createCGImage(result, fromRect: result.extent())
    return UIImage(CGImage: resultRef)!
  
  }
}
