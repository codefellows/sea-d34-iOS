//
//  PhotoViewController.swift
//  ImageFilters
//
//  Created by Bradley Johnson on 4/6/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource {
  
   let alertController = UIAlertController(title: "Options", message: "Choose One", preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  let imageToUploadSize = CGSize(width: 400, height: 400)

  //MARK: CollectionView Constraints
  @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
  
  //MARK: ImageView Constraints
  @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
  
  var originalImageViewTopLeadingTrailingConstaint : CGFloat = 0.0
  var originalImageViewBottomConstant : CGFloat = 0.0
  
  let constraintBuffer : CGFloat = 50
  let constraintAnimationDuration = 0.3
  let collectionViewHeight : CGFloat = 75
  let collectionViewFilterModeBottomConstant : CGFloat = 8
  let thumbnailSize = CGSize(width: 75, height: 75)
  
  var filters : [(UIImage, CIContext)->(UIImage)]!
  var context : CIContext!
  //var filters = Array<(UIImage,CIContext) -> (UIImage)>()
  
  var originalThumbnail : UIImage!
  var currentImage : UIImage! {
    didSet {
      self.primaryImageView.image = self.currentImage
      self.originalThumbnail = ImageResizer.resizeImage(self.currentImage, size: self.thumbnailSize)
      self.collectionView.reloadData()
      //self.currentImage = oldValue
    }
  }
  
  
  //MARK: Interface Outlets
  @IBOutlet weak var primaryImageView: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var photoButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.title = "Upload"
      
      let options = [kCIContextWorkingColorSpace : NSNull()]
      let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
      self.context = CIContext(EAGLContext: eaglContext, options: options)
      
      self.filters = [FilterService.sepia,FilterService.colorInvert, FilterService.instant, FilterService.chrome, FilterService.noir]

      self.collectionView.dataSource = self
      self.collectionViewBottomConstraint.constant = -self.tabBarController!.tabBar.frame.height - self.collectionView.frame.height
      
      self.originalImageViewTopLeadingTrailingConstaint = self.imageViewTopConstraint.constant
      self.originalImageViewBottomConstant = self.imageViewBottomConstraint.constant
      
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action) -> Void in
          
          let imagePickerController = UIImagePickerController()
          imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
          imagePickerController.allowsEditing = true
          self.presentViewController(imagePickerController, animated: true, completion: nil)
          imagePickerController.delegate = self
          //imagePickerController.mediaTypes = [UIImagePickerControllerMediaType]
        }
        self.alertController.addAction(cameraAction)
      }
      
      let filtersAction = UIAlertAction(title: "Filters", style: UIAlertActionStyle.Default) { [weak self] (action) -> Void in
        if self != nil {
        self!.enterFilterMode()
        }

      }
      self.alertController.addAction(filtersAction)
      
      let uploadAction = UIAlertAction(title: "Upload", style: UIAlertActionStyle.Default) { (action) -> Void in
        
        ParseService.uploadImage(self.primaryImageView.image!, size: self.imageToUploadSize, completionHandler: { (errorDescription) -> Void in
          
        })
      }
      self.alertController.addAction(uploadAction)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
        
        
      }
      self.alertController.addAction(cancelAction)

      self.currentImage = UIImage(named: "photo.jpg")
        // Do any additional setup after loading the view.
    }
  
  func enterFilterMode() {
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "leaveFilterMode")
    self.photoButton.enabled = false
    
    self.imageViewTopConstraint.constant = self.imageViewTopConstraint.constant + self.constraintBuffer
    self.imageViewBottomConstraint.constant = self.imageViewBottomConstraint.constant + self.constraintBuffer
    self.imageViewLeadingConstraint.constant = self.imageViewLeadingConstraint.constant + self.constraintBuffer
    self.imageViewTrailingConstraint.constant += self.constraintBuffer
    self.collectionViewBottomConstraint.constant = self.collectionViewFilterModeBottomConstant
    
    UIView.animateWithDuration(self.constraintAnimationDuration, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
    
  }
  
  func leaveFilterMode() {
    
    self.navigationItem.rightBarButtonItem = nil
    self.photoButton.enabled = true
    
    self.imageViewTopConstraint.constant = self.originalImageViewTopLeadingTrailingConstaint
    self.imageViewBottomConstraint.constant = self.originalImageViewBottomConstant
    self.imageViewTrailingConstraint.constant = self.originalImageViewTopLeadingTrailingConstaint
    self.imageViewLeadingConstraint.constant = self.originalImageViewTopLeadingTrailingConstaint
    self.collectionViewBottomConstraint.constant = -self.tabBarController!.tabBar.frame.height - self.collectionView.frame.height
    
    UIView.animateWithDuration(self.constraintAnimationDuration, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
    
  }

  @IBAction func photoButtonPressed(sender: AnyObject) {
    
    if let popoverController = self.alertController.popoverPresentationController {
      if let button = sender as? UIButton {
        popoverController.sourceView = button
        popoverController.sourceRect = button.bounds
      }
    }
    
    self.presentViewController(alertController, animated: true) { () -> Void in
      
    }
  }

  //MARK:
  //MARK: UIImagePickerControllerDelegate
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
     self.currentImage = editedImage
    }
    
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
  }
  
  //MARK: UICollectionViewDataSource
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.filters.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as ImageCell
    
    let filter = self.filters[indexPath.row]
    cell.imageView.image = filter(self.originalThumbnail,self.context)
  
    return cell
  }

}
