//
//  KNavigationController.swift
//  KNavigationViewControllerTest
//
//  Created by ksnowlv on 2017/12/12.
//  Copyright © 2017年 ksnowlv. All rights reserved.
//

import UIKit

class KNavigationController: UINavigationController,UINavigationControllerDelegate,UIGestureRecognizerDelegate  {
    
    static var navigationTransitionAnimationDisable:Bool = false

    var isStatusBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setNavigationBarHidden(true, animated: false)
        weak var weakSelf = self;
        
        self.interactivePopGestureRecognizer?.delegate = weakSelf
        self.delegate = weakSelf
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //animation
    class func setNavigationTransitionAnimationDisable(isAnimationDisable:Bool){
        KNavigationController.navigationTransitionAnimationDisable = isAnimationDisable
    }
    
    //status bar
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    override var childViewControllerForStatusBarHidden: UIViewController? {
        return (self.isStatusBarHidden ? nil:self.topViewController)
    }
    
    //push action
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        self.interactivePopGestureRecognizer?.isEnabled = false
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: KNavigationController.navigationTransitionAnimationDisable ? false :animated)
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: KNavigationController.navigationTransitionAnimationDisable ? false: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: KNavigationController.navigationTransitionAnimationDisable ? false: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return super.popToViewController(viewController, animated: KNavigationController.navigationTransitionAnimationDisable ? false: animated)
    }
    
    //UIScreenEdgePanGestureRecognizer&tableview
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }


}
