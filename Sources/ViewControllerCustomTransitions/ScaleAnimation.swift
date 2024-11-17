//
//  ScaleAnimation.swift
//
//
//  Created by Inna Boiko on 13.11.2024.
//
import UIKit
/**
 This enum defines the different shape options that can be used for scale transition.
 - Parameters:
    - `square`: A square shape
    - `circle`: A circular shape
    - `roundedRect`: A rectangular shape with rounded corners, where you can specify the corner radius.
 */
public enum ShapeOption {
    case square
    case circle
    case roundedRect(cornerRadius: CGFloat)
}
/**
 This class handles the scale animation transition of view controller. It is a subclass of `BasicAnimation` and 
 overrides the `animateTransition(using:)` method to perform a scale effect for the destination view controller.
*/
internal class ScaleAnimation: BasicAnimation {
    
    public var initialScale: CGFloat
    public var finalScale: CGFloat
    public var damping: CGFloat
    public var springVelocity: CGFloat
    public var delay: TimeInterval
    public var shape: ShapeOption

    internal init(delay: TimeInterval = 0,
                duration: TimeInterval = 0.5,
                initialScale: CGFloat = 0.0,
                finalScale: CGFloat = 1.0,
                damping: CGFloat = 0.8,
                springVelocity: CGFloat = 0.1,
                shape: ShapeOption = .square) {
        
        self.initialScale = initialScale
        self.finalScale = finalScale
        self.damping = damping
        self.springVelocity = springVelocity
        self.delay = delay
        self.shape = shape
        super.init(duration: duration)
    }
    
    internal override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        
        let validInitialScale = max(initialScale, 0.01)
        let validFinalScale = max(finalScale, 0.01)
        
        
        applyShape(to: toView, initial: true)
        
        toView.transform = CGAffineTransform(scaleX: validInitialScale, y: validInitialScale)
        toView.clipsToBounds = true
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: springVelocity,
                       options: [.curveEaseInOut],
                       animations: {
            toView.transform = CGAffineTransform(scaleX: validFinalScale, y: validFinalScale)
            self.applyShape(to: toView, initial: false)
           
        }) { _ in
            transitionContext.completeTransition(true)
            
        }
    }
    
  
    private func applyShape(to view: UIView, initial: Bool) {
        switch shape {
        case .square:
            view.layer.cornerRadius = 0
        case .circle:
           
            let radius = min(view.bounds.width, view.bounds.height) / 2
            view.layer.cornerRadius = initial ? radius : 0
        case .roundedRect(let cornerRadius):
            view.layer.cornerRadius = initial ? cornerRadius : 0
        }
    }
}
