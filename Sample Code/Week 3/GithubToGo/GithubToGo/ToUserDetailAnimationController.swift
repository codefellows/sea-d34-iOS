//
//  ToUserDetailAnimationController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit


class ToUserDetailAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
  
  let duration = 0.4
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }

  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UserSearchViewController
    let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! UserDetailViewController
    let containerView = transitionContext.containerView()
    
    toVC.view.alpha = 0
    containerView.addSubview(toVC.view)
    
    let selectedIndexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
    let userCell = fromVC.collectionView.cellForItemAtIndexPath(selectedIndexPath) as! UserCell
    let snapShot = userCell.imageView.snapshotViewAfterScreenUpdates(false)
    userCell.hidden = true
    snapShot.frame = containerView.convertRect(userCell.imageView.frame, fromCoordinateSpace: userCell.imageView.superview!)
    containerView.addSubview(snapShot)
    toVC.view.layoutIfNeeded()
    
    let frame = containerView.convertRect(toVC.imageView.frame, fromView: toVC.view)
    toVC.imageView.hidden = true
    
    
    UIView.animateWithDuration(duration, animations: { () -> Void in
      toVC.view.alpha = 1
      snapShot.frame = frame
      
    }) { (finished) -> Void in
      if finished {
         toVC.imageView.hidden = false
        snapShot.removeFromSuperview()
        userCell.hidden = false
        transitionContext.completeTransition(true)
      } else {
      transitionContext.completeTransition(false)
      }
    }
    
    
    
  }
  
  
}