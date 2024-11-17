//
//  BasicAnimation.swift
//  
//
//  Created by Inna Boiko on 12.11.2024.
//

import Foundation
import UIKit
/**
 This class provides the base for creating custom view controller transition animations.
 It implements the `UIViewControllerAnimatedTransitioning` protocol, allowing you to define custom transitions
 when transitioning between view controllers.

 - Parameters:
   - duration: The duration of the transition animation. The default value is 0.5 seconds.

 - Methods:
   - `transitionDuration(using:)`: Returns the duration of the transition animation.
   - `animateTransition(using:)`: This method should be overridden in subclasses to define custom animation behavior. By default, it triggers a `fatalError`, indicating that subclasses need to provide their own implementation.
 
 Example of a subclass:
 ```swift
 class CustomAnimation: BasicAnimation {
     override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
         // Define custom transition logic here
     }
 }
 */
public class BasicAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval
    
    public init(duration: TimeInterval = 0.5) {
        self.duration = duration
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
   
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        fatalError("animateTransition must be overridden in subclasses")
    }
}
/**
 This enum defines different animation types that can be applied to transitions between view controllers.
  Refer to documentation of each case to see details of it
 */
public enum AnimationType {
    ///Basic scale transition with no custom parameters.
    case scale
    ///Scale transition with custom parameters(which have default value as in basic scale), including delay of animation, 
    ///duration, initial and final scale, damping, spring velocity, and shape(square, circle or rounded rectangle).
    case customScale(delay: TimeInterval = 0,
                     duration: TimeInterval = 0.5,
                     initialScale: CGFloat = 0.0,
                     finalScale: CGFloat = 1.0,
                     damping: CGFloat = 0.8,
                     springVelocity: CGFloat = 0.1,
                     shape: ShapeOption = .square)
    ///Basic appearing of next view.
    case fadeIn
    ///Fade-in transition with custom duration, delay, and final alpha values.
    case customFadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0, finalAlpha: CGFloat = 1.0)
    ///Scale animation but default shape is circle
    case shrink
    ///Rotate transition in a clockwise direction.
    case rotateClockwise
    ///Rotate transition in a clockwise direction.
    case rotateCounterClockwise
    ///Custom rotation with adjustable duration, angles, and rotation direction(clockwise or not).
    case rotate(duration: TimeInterval = 0.5, startAngle: CGFloat = 0, endAngle: CGFloat = 2 * .pi, clockwise: Bool = true)
    ///Custom slide with adjustable durations and direction.
    case customSlide(duration: TimeInterval = 0.5, direction: Direction = .leftToRight)
    ///Slide transition moving from left to right.
    case slideToRight
    ///Slide transition moving from right to left.
    case slideToLeft
    ///Slide transition moving from top to bottom.
    case slideToBottom
    ///Slide transition moving from bottom to top.
    case slideToTop
    /// A custom animation created by a `CustomAnimation` instance.
    case customAnimation(CustomAnimation)
    
    
   
    
    func createAnimator() -> UIViewControllerAnimatedTransitioning {
        switch self {
        case .scale:
            return ScaleAnimation()
        case .fadeIn:
            return FadeAnimator()
        case .customFadeIn(duration: let duration, delay: let delay, finalAlpha: let finalAlpha):
            return FadeAnimator(duration:  duration, delay:  delay, finalAlpha: finalAlpha)
        case .shrink:
            return ScaleAnimation(initialScale: 0.0, finalScale: 1.0, shape: .circle)
        case .rotateClockwise:
            return RotateTransition()
        case .rotateCounterClockwise:
            return RotateTransition(clockwise: false)
        case .rotate(duration: let duration, startAngle: let startAngle, endAngle: let endAngle, clockwise: let clockwise):
            return RotateTransition(duration: duration, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        case .slideToRight:
            return SlideTransition(direction: .leftToRight)
        case .slideToLeft:
            return SlideTransition(direction: .rightToLeft)
        case .slideToBottom:
            return SlideTransition(direction: .topToBottom)
        case .slideToTop:
            return SlideTransition(direction: .bottomToTop)
        case .customSlide(duration: let duration, direction: let direction):
            return SlideTransition(duration:  duration, direction:  direction)
        case .customScale(delay: let delay, duration: let duration, initialScale: let initialScale, finalScale: let finalScale, damping: let damping, springVelocity: let springVelocity, shape: let shape):
            return ScaleAnimation(delay:  delay, duration:  duration, initialScale:  initialScale, finalScale:  finalScale, damping:  damping, springVelocity:  springVelocity, shape:  shape)
        case .customAnimation(let customAnimation):
                   return customAnimation
               }
        }
    }
