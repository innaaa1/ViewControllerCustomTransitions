
import UIKit


extension UIViewController {
    /**
     This method uses a custom animation to animate the transition to a new view controller.
     
     - Parameters:
        - viewController: The view controller to transition to.
        - withAnimation: The type of animation to apply. This should be an `AnimationType` object, which determines how the transition will be animated. Refer to the `AnimationType` enum to see all available options.
     
     - Note:
       - Use this method only when the next controller **does not contain** a `UITableView`
         or other components that are configured in a Storyboard. If the next controller uses components
         from a Storyboard, it's recommended to use the `CustomSegue` class for your segue.
       - Create a `UINavigationController` as the initial controller in the Storyboard to get correct and smooth animations.
     
     - Example:
       ```swift
       let newViewController = YourViewController()
       customAnimation(newViewController, withAnimation: .fadeIn)

     */
    public func customAnimation(_ viewController: UIViewController, withAnimation animationType: AnimationType) {
        
        let animator = animationType.createAnimator()
        
        
        let transitionContext = CustomTransitionContext(fromViewController: self, toViewController: viewController, containerView: self.view)
        
      
        animator.animateTransition(using: transitionContext)
        
     
        if let navController = self.navigationController {
            navController.pushViewController(viewController, animated: false)
        } else {
            let navController = UINavigationController(rootViewController: viewController)
            viewController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
}
