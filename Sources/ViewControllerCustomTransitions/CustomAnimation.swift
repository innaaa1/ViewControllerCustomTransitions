//
//  CustomAnimation.swift
//
//
//  Created by Inna Boiko on 12.11.2024.
//

import UIKit
/**
 This class allows  to create and execute custom animations during view controller transitions.

 - Parameters:
    - `duration`: The duration of the animation in seconds. Default is 0.5 seconds.
    - `delay`: The delay before the animation starts, in seconds. Default is 0.0 seconds.
    - `damping`: The damping ratio to control the bounciness of the animation. Default is 0.8.
    - `velocity`: The initial velocity of the animation's spring effect. Default is 0.5.
    - `animationOptions`: The animation options to control the curve and timing of the animation. Default is `.curveEaseInOut`.
    - `animationSetup`: A closure that gets called before the animation starts. It can be used for additional setup on the `toView` (the view being presented).
    - `animationExecution`: A closure that defines the animation to be performed. This will be executed within the `UIView.animate` block.
    - `completion`: A closure that gets called when the animation completes, with a `Bool` indicating if the animation finished successfully.

 - Usage:
    1. Create a `CustomAnimation` instance, providing the desired animation parameters (duration, delay, damping, etc.).
    2. Optionally, define the `animationSetup` and `animationExecution` closures to customize the setup and animation behavior.
    3. Add your instance as a paraments to the case `.customAnimation` of `AnimationType` enum

 Example:
 ```swift
 let scaleAnimation = CustomAnimation(duration: 0.5,
                                      delay: 0.0,
                                      damping: 0.8,
                                      velocity: 0.5,
                                      animationSetup: { view in

                                          view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                                      },
                                      animationExecution: { view in
                                         
                                          view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                      },
                                      completion: { finished in
                                          if finished {
                                              print("Is finished.")
                                          } else {
                                              print("Is not finished.")
                                          }
                                      })
*/
public class CustomAnimation: BasicAnimation {

    public var animationSetup: ((UIView) -> Void)?
    public var animationExecution: ((UIView) -> Void)?
    
   
    public var delay: TimeInterval
    public var damping: CGFloat
    public var velocity: CGFloat
    public var animationOptions: UIView.AnimationOptions
    public var completion: ((Bool) -> Void)?

    public init(duration: TimeInterval = 0.5,
                delay: TimeInterval = 0.0,
                damping: CGFloat = 0.8,
                velocity: CGFloat = 0.5,
                animationOptions: UIView.AnimationOptions = [.curveEaseInOut],
                animationSetup: ((UIView) -> Void)? = nil,
                animationExecution: ((UIView) -> Void)? = nil,
                completion: ((Bool) -> Void)? = nil) {
        self.delay = delay
        self.damping = damping
        self.velocity = velocity
        self.animationOptions = animationOptions
        self.completion = completion
        self.animationSetup = animationSetup
        self.animationExecution = animationExecution
        super.init(duration: duration)
    }
    
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let _ = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)

        
        animationSetup?(toView)
        
       
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: animationOptions,
                       animations: {
            self.animationExecution?(toView)
        }) { finished in
            self.completion?(finished)
            transitionContext.completeTransition(finished)
        }
    }
}
