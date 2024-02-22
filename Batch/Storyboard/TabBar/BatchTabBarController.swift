//
//  BatchTabBarController.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 27/12/23.
//

import UIKit

class BatchTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addShadow()
        self.delegate = self
    }
    private func addShadow() {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4.0
        //            tabBar.layer.shadowColor = Colors.appBorderLightColor.cgColor
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        
        tabBar.layer.shadowOpacity = 0.6
        //            tabBar.backgroundColor = Colors.appViewBackgroundColor
        tabBar.backgroundColor = UIColor.white
        
        
        //        layer.shadowOffset = CGSize(width: 0, height: -3)
        //        layer.shadowColor = UIColor.black.cgColor
        //        layer.shadowOpacity = 0.3
        //        layer.shadowRadius = 5
        //        layer.masksToBounds = false
    }
    
}

extension BatchTabBarController: UITabBarControllerDelegate
{
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return TabViewAnimation()
    }
    
    
    //    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    //
    //        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
    //            return false // Make sure you want this as false
    //        }
    //
    //        if fromView != toView {
    //            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
    //        }
    //
    //        return true
    //    }
    
}

class TabViewAnimation: NSObject, UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: .to) else { return }
        
        destination.transform = CGAffineTransform(translationX: 0, y: destination.frame.height)
        transitionContext.containerView.addSubview(destination)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.transform = .identity
        }, completion: {
            transitionContext.completeTransition($0)
        })
    }
}


/*
 extension BatchTabBarController: UITabBarControllerDelegate {
 
 public func tabBarController(
 _ tabBarController: UITabBarController,
 animationControllerForTransitionFrom fromVC: UIViewController,
 to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
 return FadePushAnimator()
 }
 }
 class FadePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
 
 func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
 return 0.3
 }
 
 func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
 guard
 let toViewController = transitionContext.viewController(forKey: .to)
 else {
 return
 }
 
 transitionContext.containerView.addSubview(toViewController.view)
 toViewController.view.alpha = 0
 
 let duration = self.transitionDuration(using: transitionContext)
 UIView.animate(withDuration: duration, animations: {
 toViewController.view.alpha = 1
 }, completion: { _ in
 transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
 })
 
 }
 }
 
 */
