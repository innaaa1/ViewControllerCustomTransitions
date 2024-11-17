//
//  CustomTransitionContext.swift
//
//
//  Created by Inna Boiko on 15.11.2024.
//

import UIKit

/**
 This class is a custom implementation of `UIViewControllerContextTransitioning`, 
 which manages the context for view controller transitions during custom animations.
*/
internal class CustomTransitionContext: NSObject, UIViewControllerContextTransitioning {
    
    
    var presentationStyle: UIModalPresentationStyle = .overFullScreen
    var targetTransform: CGAffineTransform = .identity
    
    var isAnimated: Bool = true
    var isInteractive: Bool = false
    var transitionWasCancelled: Bool = false
    
    private var fromViewController: UIViewController
    private var toViewController: UIViewController
    internal var containerView: UIView
    
    init(fromViewController: UIViewController, toViewController: UIViewController, containerView: UIView) {
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        self.containerView = containerView
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case .from:
            return fromViewController.view
        case .to:
            return toViewController.view
        default:
            return nil
        }
    }
    
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        switch key {
        case .from:
            return fromViewController
        case .to:
            return toViewController
        default:
            return nil
        }
    }
    
    func completeTransition(_ didComplete: Bool) {
     
        if didComplete {
           
            fromViewController.view.layer.removeAllAnimations()
            
       
            fromViewController.view.removeFromSuperview()
        } else {
        
            toViewController.view.removeFromSuperview()
        }
    }
    
    
    func initialFrame(for vc: UIViewController) -> CGRect {
        return vc.view.frame
    }
    
    func finalFrame(for vc: UIViewController) -> CGRect {
        return vc.view.frame
    }
    
    func updateInteractiveTransition(_ percentComplete: CGFloat) {
        //
    }
    
    func finishInteractiveTransition() {
        //
    }
    
    func cancelInteractiveTransition() {
        //
    }
    
    func pauseInteractiveTransition() {
        //
    }
}
