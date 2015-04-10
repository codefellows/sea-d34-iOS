//
//  GalleryViewController.swift
//  ImageFilters
//
//  Created by Bradley Johnson on 4/9/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit
import Photos


protocol ImageSelectedDelegate : class  {
  func controllerDidSelectImage(image : UIImage) -> Void
}

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

  var results : PHFetchResult!
  var imageManager : PHCachingImageManager!
  var primaryImageViewSize : CGSize!
  
  weak var delegate : ImageSelectedDelegate?
  
  var flowlayout : UICollectionViewFlowLayout!
  
  let cellSize = CGSize(width: 100, height: 100)
  
  @IBOutlet weak var collectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
       //self.collectionView.dataSource = self
      
      let pinch = UIPinchGestureRecognizer(target: self, action: "collectionViewPinched:")
      self.collectionView.addGestureRecognizer(pinch)
      
      self.flowlayout = self.collectionView.collectionViewLayout as UICollectionViewFlowLayout
    
      
      self.results = PHAsset.fetchAssetsWithOptions(nil)
      self.collectionView.dataSource = self
      self.collectionView.delegate = self
      
     self.imageManager = PHCachingImageManager()
        // Do any additional setup after loading the view.
    }

//MARK: UICollectionViewDataSource
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCell", forIndexPath: indexPath) as GalleryCell
    
    let asset = self.results[indexPath.row] as PHAsset
    
    self.imageManager.requestImageForAsset(asset, targetSize: cell.frame.size, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
      if image != nil {
        cell.imageView.image = image
      }
    }
    return cell
  }
  
  //MARK: UICollectionViewDelegate
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let asset = self.results[indexPath.row] as PHAsset
    
    self.imageManager.requestImageForAsset(asset, targetSize:self.primaryImageViewSize , contentMode: PHImageContentMode.AspectFill, options: nil) {[weak self] (image, info) -> Void in
      if self != nil {
        if image != nil {
          self!.delegate?.controllerDidSelectImage(image)
          self!.navigationController?.popToRootViewControllerAnimated(false)
        }
      }
    }
  }
  func collectionViewPinched(pinch : UIPinchGestureRecognizer) {
    if pinch.state == UIGestureRecognizerState.Changed {
      println(pinch.scale)
      let oldSize = self.flowlayout.itemSize
      let newSize = CGSize(width: cellSize.width * pinch.scale, height: cellSize.height * pinch.scale)
      self.flowlayout.itemSize = newSize
      
      self.collectionView.performBatchUpdates({ () -> Void in
        self.flowlayout.invalidateLayout()
      }, completion: nil)
      //self.flowlayout.invalidateLayout()
    }
    
  }
}
