//
//  SideMenuBuilder.swift
//  kr
//
//  Created by FanFamily on 16/1/20.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit
import SnapKit
import EasyAnimation
import DKChainableAnimationKit

@objc protocol SideMenuBuilderDelegate {
    optional func willChangeLeftSpace(space:CGFloat)
    optional func didChangeLeftSpace(space:CGFloat)
}

class SideMenuBuilder: NSObject {
    
    var containVC:UIViewController
    
    var leftVC:UIViewController
    
    var rightVC:UIViewController
    
    var menuButton:UIButton
    
    var leftSpace:CGFloat = 50
    
    var expand:Bool = false
    
    var statusBarHeight:CGFloat {
        return 20
    }
    
    var delegate: SideMenuBuilderDelegate?
    
    init(containVC:UIViewController, leftVC:UIViewController, rightVC:UIViewController, menuButton:UIButton) {
        self.containVC = containVC;
        self.leftVC = leftVC;
        self.rightVC = rightVC;
        self.menuButton = menuButton
        self.delegate = nil
    }
    
    func build() {
        // 将两个vc加到container中
        containVC.addChildViewController(rightVC)
        containVC.view.addSubview(rightVC.view)
        rightVC.didMoveToParentViewController(containVC)
        
        containVC.addChildViewController(leftVC)
        containVC.view.addSubview(leftVC.view)
        leftVC.didMoveToParentViewController(containVC)
        
        // 添加一个按钮在左上角
        rightVC.view.addSubview(menuButton)
        self.menuButton.addTarget(self, action: "menuButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // 设置约束
        leftVC.view.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(containVC.view.snp_left)
            make.right.equalTo(containVC.view.snp_left)
            make.top.equalTo(containVC.view.snp_top).offset(statusBarHeight)
            make.bottom.equalTo(containVC.view.snp_bottom)
        }
        
        // 设置约束
        rightVC.view.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(leftVC.view.snp_left)
            make.right.equalTo(containVC.view.snp_right)
            make.top.equalTo(containVC.view.snp_top).offset(statusBarHeight)
            make.bottom.equalTo(containVC.view.snp_bottom)
        }
        
        menuButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(rightVC.view.snp_left)
            make.top.equalTo(rightVC.view.snp_top)
            make.width.equalTo(menuButton.frame.width)
            make.height.equalTo(menuButton.frame.height)
        }
    }
    
    func menuButtonAction(sender:AnyObject) {
        if !expand {
            expand = true
            changeLeftSpace(leftSpace)
        } else {
            expand = false
            changeLeftSpace(0)
        }
    }
    
    func changeLeftSpace(space:CGFloat) {
        self.delegate!.willChangeLeftSpace!(space)
        if space == 0 {
            leftVC.view.animation.makeWidth(space).anchorLeft.animateWithCompletion(0.2, { () -> Void in
                self.delegate!.didChangeLeftSpace!(0)
            })
            rightVC.view.animation.makeX(space).animate(0.1)
        } else {
            leftVC.view.animation.makeWidth(space).anchorLeft.animate(0.1)
            rightVC.view.animation.makeX(space).animateWithCompletion(0.2, { () -> Void in
                self.delegate!.didChangeLeftSpace!(space)
            })
        }
    }
}
