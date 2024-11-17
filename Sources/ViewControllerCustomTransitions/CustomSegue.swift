//
//  CustomSegue.swift
//  
//
//  Created by Inna Boiko on 15.11.2024.
//

import UIKit
/**
 This class allows you to perform a custom transition animation using a segue in Storyboard.
 
 - Parameters:
   - animationType: The animation style to use for the transition. Refer to the `AnimationType` enum for available options.
 
 - Usage:
    1. **Create a Segue**: In your storyboard, create a segue by control-dragging between view controllers.
       (Optionally, you can programmatically initiate a `CustomSegue` in code.)
    
    2. **Set the Segue Kind**: Select the newly created segue, open the Attributes Inspector, and set its kind to **Custom**.
    
    3. **Assign the Class**: In the Class field (found in the Attributes Inspector), enter `CustomSegue`.
    
    4. **Default Animation**: The default animation type is set to `.slideToRight`.
       - If you want to change the animation style, you can modify it in the `prepare(for:sender:)` method in your ViewController class:
       
       ```swift
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "YourSegueIdentifier" {
               if let customSegue = segue as? CustomSegue {
                   customSegue.animationType = .slideToBottom // Customize animation
               }
           }
       }
       ```
       
 - Note: Usage of a `UINavigationController` as the initial controller is necessary to achieve smooth animations.
 */

open class CustomSegue: UIStoryboardSegue {
    
   open var animationType: AnimationType
    
    public init(identifier: String?, source: UIViewController, destination: UIViewController, animationType: AnimationType) {
          self.animationType = animationType
          super.init(identifier: identifier, source: source, destination: destination)
      }
    override public init(identifier: String?, source: UIViewController, destination: UIViewController) {
            self.animationType = .slideToRight 
           super.init(identifier: identifier, source: source, destination: destination)
       }
    open override func perform() {
       
        var toViewController = self.destination
        let fromViewController = self.source
       
          if let navController = fromViewController.navigationController {
    
        toViewController.modalPresentationStyle = .fullScreen
        let animator = animationType.createAnimator()
              let context = CustomTransitionContext(fromViewController: fromViewController, toViewController: toViewController, containerView: fromViewController.view)
        animator.animateTransition(using: context)
        navController.pushViewController(toViewController, animated: false)
    } else {
        let navController = UINavigationController(rootViewController: toViewController)
        toViewController.modalPresentationStyle = .fullScreen
        fromViewController.present(navController, animated: true, completion: nil)
    }
    }
    
    @objc func backAction() {
          self.source.dismiss(animated: true, completion: nil)
      }
}


