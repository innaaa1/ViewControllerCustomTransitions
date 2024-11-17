//
//  RotateTransition.swift
//
//
//  Created by Inna Boiko on 13.11.2024.
//
import UIKit

/**
 This class handles the rotate animation transition of view controller. It is a subclass of `BasicAnimation` and 
 overrides the `animateTransition(using:)` method to perform a rotate effect for the destination view controller.
*/
internal class RotateTransition: BasicAnimation {
    
  
    public var startAngle: CGFloat
    
   
    public var endAngle: CGFloat


    public var clockwise: Bool

    internal init(duration: TimeInterval = 0.5, startAngle: CGFloat = 0, endAngle: CGFloat = 2 * .pi, clockwise: Bool = true) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.clockwise = clockwise
        super.init(duration: duration)
    }

    internal override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
       
        let adjustedEndAngle = clockwise ? endAngle : -endAngle
        
       
        toView.transform = CGAffineTransform(rotationAngle: startAngle)
        
      
        UIView.animate(withDuration: duration, animations: {
            if adjustedEndAngle == 2 * .pi {
              
                toView.transform = CGAffineTransform(rotationAngle: .pi)
                toView.transform = CGAffineTransform(rotationAngle: 4 * .pi/2)
            } else if adjustedEndAngle == -2 * .pi {
              
                toView.transform = CGAffineTransform(rotationAngle: 3 * .pi / 2)
                toView.transform = CGAffineTransform(rotationAngle: .pi)
               toView.transform = CGAffineTransform(rotationAngle: .pi/4)
                toView.transform = CGAffineTransform(rotationAngle: .pi * 0)
              
             
            } else {
               
                toView.transform = CGAffineTransform(rotationAngle: adjustedEndAngle)
            }
        }) { _ in
           
            transitionContext.completeTransition(true)
            
        }
    }
}
