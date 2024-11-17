//
//  SlideTransition.swift
//
//
//  Created by Inna Boiko on 13.11.2024.

import UIKit

public enum Direction {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}
/**
 This class handles the slide animation transition of view controller. It is a subclass of `BasicAnimation` and 
 overrides the `animateTransition(using:)` method to perform a slide effect for the destination view controller.
*/
internal class SlideTransition: BasicAnimation {
    
    public var direction: Direction
    
    public init(duration: TimeInterval = 0.5, direction: Direction = .leftToRight) {
        self.direction = direction
        super.init(duration: duration)
    }
    
    internal override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
       
        var offscreenTransform: CGAffineTransform
        switch direction {
        case .leftToRight:
            offscreenTransform = CGAffineTransform(translationX: -containerView.bounds.width, y: 0)
        case .rightToLeft:
            offscreenTransform = CGAffineTransform(translationX: containerView.bounds.width, y: 0)
        case .topToBottom:
            offscreenTransform = CGAffineTransform(translationX: 0, y: -containerView.bounds.height)
        case .bottomToTop:
            offscreenTransform = CGAffineTransform(translationX: 0, y: containerView.bounds.height)
        }
       
        toView.transform = offscreenTransform
        
       
        UIView.animate(withDuration: duration, animations: {
            toView.transform = .identity
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
