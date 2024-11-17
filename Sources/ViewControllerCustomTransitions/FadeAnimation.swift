//
//  FadeAnimation.swift
//  
//
//  Created by Inna Boiko on 13.11.2024.
//

import Foundation
import UIKit
/**
 This class handles the fade-in animation transition between view controllers. It is a subclass of `BasicAnimation` and 
 overrides the `animateTransition(using:)` method to perform a fade-in effect for the destination view controller.
*/

internal class FadeAnimator: BasicAnimation {
    public var finalAlpha: CGFloat
    public var delay: TimeInterval
    
    internal init(duration: TimeInterval = 0.5, delay: TimeInterval = 0, finalAlpha: CGFloat = 1.0) {
        self.finalAlpha = finalAlpha
        self.delay = delay
        super.init(duration: duration)
    }
    
    internal override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        toView.alpha = 0.0
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: [.curveEaseInOut],
                       animations: {
            toView.alpha = self.finalAlpha
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
