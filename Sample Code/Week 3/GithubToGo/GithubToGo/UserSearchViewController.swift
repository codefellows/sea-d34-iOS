//
//  UserSearchViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController,UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  let imageFetchService = ImageFetchService()
  
  var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.collectionView.dataSource = self
      self.searchBar.delegate = self
      self.navigationController?.delegate = self

        // Do any additional setup after loading the view.
    }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    GithubService.sharedInstance.fetchUsersForSearch(searchBar.text, completionHandler: { (users, error) -> (Void) in
      self.users = users!
      self.collectionView.reloadData()
    })
  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
    cell.imageView.image = nil
    let user = self.users[indexPath.row]
    if user.avatarImage != nil {
      cell.imageView.image = user.avatarImage
    } else {
      self.imageFetchService.fetchImageForURL(user.avatarURL, completionHandler: { (downloadedImage) -> (Void) in
        cell.imageView.alpha = 0
        cell.imageView.transform = CGAffineTransformMakeScale(2.0, 2.0)
        user.avatarImage = downloadedImage
        cell.imageView.image = downloadedImage
        UIView.animateWithDuration(0.4, animations: { () -> Void in
          cell.imageView.alpha = 1
          cell.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        })
      })
      
    }
    
    return cell
  }
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    if toVC is UserDetailViewController {
      return ToUserDetailAnimationController()
    }
    
    return nil
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowUser" {
      let destination = segue.destinationViewController as! UserDetailViewController
      let indexPath = self.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      let user = self.users[indexPath.row]
      destination.selectedUser = user
    }
  }
  

}
