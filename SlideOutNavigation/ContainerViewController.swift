//
//  ContainerViewController.swift
//  AdsForCharity
//


import UIKit
import QuartzCore

enum MenuState {
    case MenuCollapsed
    case MenuExpanded
}

class ContainerViewController: UIViewController, SidePanelViewControllerDelegate, UIGestureRecognizerDelegate {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var menuViewController: SidePanelViewController?
    var loginViewController: LoginViewController?
    var currentViewController: UIViewController?
    
    var menuState: MenuState = .MenuCollapsed {
        didSet {
            let shouldShowShadow = menuState != .MenuCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    let centerPanelExpandedOffset: CGFloat = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleMenuPanel")
        currentViewController = centerViewController
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
  
    // MARK: CenterViewController delegate methods
  
    func toggleMenuPanel() {
        let notAlreadyExpanded = (menuState != .MenuExpanded)
        
        addMenuPanelViewController()
        animateMenuPanel(shouldExpand: notAlreadyExpanded)
    }
  
    func addMenuPanelViewController() {
        if (menuViewController == nil) {
            menuViewController = UIStoryboard.menuViewController()
            menuViewController!.menuItems = MenuItem.allMenuItems()
            
            addChildSidePanelController(menuViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = self
        
        view.insertSubview(sidePanelController.view, atIndex: 0)
        
        addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
  
    func animateMenuPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            menuState = .MenuExpanded
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.menuState = .MenuCollapsed
                
                self.menuViewController!.view.removeFromSuperview()
                self.menuViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
  
    // MARK: Gesture recognizer
  
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
            case .Began:
                if (menuState == .MenuCollapsed) {
                    if (gestureIsDraggingFromLeftToRight) {
                        addMenuPanelViewController()
                        showShadowForCenterViewController(true)
//                        if (currentViewController == centerViewController) {
//                            centerViewController.pauseAds()
//                        }
                    }
                }
            case .Changed:
                if ((menuState == .MenuCollapsed && gestureIsDraggingFromLeftToRight) ||
                    (menuState == .MenuExpanded && !gestureIsDraggingFromLeftToRight) ) {
                    recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
                    recognizer.setTranslation(CGPointZero, inView: view)
                }
            case .Ended:
                if (menuViewController != nil) {
                    // animate the side panel open or closed based on whether the view has moved more or less than halfway
                    let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                    animateMenuPanel(shouldExpand: hasMovedGreaterThanHalfway)
                }
            default:
                break
        }
    }
    
    func menuItemSelected(menuItem: MenuItem) {
        let vc = viewController(menuItem)
//        if (vc != currentViewController && currentViewController == centerViewController) {
//            centerViewController.pauseAds()
//        }
        self.currentViewController = vc
        self.centerNavigationController.viewControllers = [vc]
        self.toggleMenuPanel()
    }
    
    func viewController(menuItem: MenuItem) -> UIViewController {
        if (menuItem.title == "Home") {
            if (centerViewController == nil) {
                centerViewController = UIStoryboard.centerViewController()
                centerViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleMenuPanel")
            }
            return centerViewController
        } else if (menuItem.title == "Account") {
            if (loginViewController == nil) {
                loginViewController = UIStoryboard.loginViewController()
                loginViewController!.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleMenuPanel")
            }
            return loginViewController!
        }
        return centerViewController
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
  
    class func menuViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("MenuViewController") as? SidePanelViewController
    }
  
    class func centerViewController() -> CenterViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController") as? CenterViewController
    }
    
    class func loginViewController() -> LoginViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
    }
}