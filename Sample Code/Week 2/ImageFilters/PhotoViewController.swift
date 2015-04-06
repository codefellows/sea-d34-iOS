//
//  PhotoViewController.swift
//  ImageFilters
//
//  Created by Bradley Johnson on 4/6/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
   let alertController = UIAlertController(title: "Options", message: "Choose One", preferredStyle: UIAlertControllerStyle.ActionSheet)

  @IBOutlet weak var primaryImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      var x = 100
      
      
      
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
      
      let sepiaAction = UIAlertAction(title: "Sepia", style: UIAlertActionStyle.Destructive) { (action) -> Void in
        
        let sepiaImage = FilterService.sepia(self.primaryImageView.image!)
        self.primaryImageView.image = sepiaImage
      }
      self.alertController.addAction(sepiaAction)

        // Do any additional setup after loading the view.
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
      self.primaryImageView.image = editedImage
    }
    
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
  }

}
