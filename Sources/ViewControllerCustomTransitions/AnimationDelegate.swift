//
//  AnimationDelegate.swift
//
//
//  Created by Inna Boiko on 12.11.2024.
//

import Foundation

import UIKit
/**
 This class is a custom transitioning delegate used to handle view controller animations during presentation transitions.

 - Inherits: `NSObject`, `UIViewControllerTransitioningDelegate`
 
 - Properties:
    - `currentAnimator`: The current animator to be used for the transition.

 - Methods:
    - `setAnimator(_:)`: Sets the animator object.
    
    - `animationController(forPresented:presenting:source:)`: Returns the animation controller to be used when presenting a view controller. This method is required by the `UIViewControllerTransitioningDelegate` protocol.
 */
public class AnimationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private var currentAnimator: BasicAnimation?
    
    public func setAnimator(_ animator: BasicAnimation) {
        currentAnimator = animator
    }
    
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return currentAnimator
    }
}
