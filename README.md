## ViewControllerCustomTransitions

## Installation

1. Add the **ViewControllerCustomTransitions** framework to your Xcode project by copying the URL and adding package dependency to the project.

   Alternatively, you can download the framework using **CocoaPods**.
   Just add this pod to your Podfile:
   ```swift
   pod 'ViewControllerCustomTransitions'

2. Import the framework in your view controllers:

   ```swift
   import ViewControllerCustomTransition
   
## Usage

Ensure the initial view controller in the Storyboard is embedded in a `UINavigationController` for correct transition behavior.

### Programmatic Transition

To perform a custom transition to a new view controller, use the `customAnimation(_:withAnimation:)` method:

    ```swift
    let newViewController = YourViewController()
    customAnimation(newViewController, withAnimation: .fadeIn)
  

## Transition Using Storyboard Segue

1. In your storyboard, create a segue between two view controllers.
2. Set the segue kind to **Custom** in the Attributes Inspector.
3. Assign the class name `CustomSegue` to the segue.
4. Customize the animation type in the `prepare(for:sender:)` method in your source view controller:

   ```swift
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "YourSegueIdentifier" {
          if let customSegue = segue as? CustomSegue {
            customSegue.animationType = .slideToBottom // Customize animation
          }
        }
    }

### Available Animations

You can specify the animation type using the `AnimationType` enum, which provides the following transitions:

- `.fadeIn`
- `.fadeOut`
- `.slideToLeft`
- `.slideToRight`
- `.slideToTop`
- `.slideToBottom`
- `.scaleUp`
- `.scaleDown`

`AnimationType` also has custom representations for fade, slide, scale, and rotate with customized fields.

## Custom Animation Example
To add fully customized transition you can use `.customAnimation` in `animation type` enum. 
This example demonstrates how to create and use custom animations:

    ```swift
    let scaleAnimation = CustomAnimation(
    duration: 0.5,
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
            print("Animation completed successfully.")
        } else {
            print("Animation did not complete.")
          }
      }
    )
    let newViewController = YourViewController()
    customAnimation(newViewController, withAnimation: .customAnimation(scaleAnimation))

  
### Notes
- Use the `customAnimation` method for view controllers that **do not** contain a `UITableView` or other components set up in Storyboard.
  For controllers that use Storyboard elements, consider using the `CustomSegue` class for smooth integration.
