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
    
    init(containVC:UIViewController, leftVC:UIViewController, rightVC:UIViewController, menuButton:UIButton) {
        self.containVC = containVC;
        self.leftVC = leftVC;
        self.rightVC = rightVC;
        self.menuButton = menuButton
    }
    
    func build() {
        // 将两个vc加到container中
        containVC.addChildViewController(leftVC)
        containVC.view.addSubview(leftVC.view)
        leftVC.didMoveToParentViewController(containVC)
        
        containVC.addChildViewController(rightVC)
        containVC.view.addSubview(rightVC.view)
        rightVC.didMoveToParentViewController(containVC)
        
        // 添加一个按钮在左上角
        containVC.view.addSubview(menuButton)
        self.menuButton.addTarget(self, action: "menuButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // 设置约束
        leftVC.view.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(containVC.view.frame.origin.x)
            make.width.equalTo(0)
            make.top.equalTo(containVC.view.frame.origin.y + statusBarHeight)
            make.bottom.equalTo(containVC.view.frame.origin.y + containVC.view.frame.height)
        }
        
        // 设置约束
        rightVC.view.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(containVC.view.frame.origin.x)
            make.width.equalTo(containVC.view.frame.size.width)
            make.top.equalTo(containVC.view.frame.origin.y + statusBarHeight)
            make.bottom.equalTo(containVC.view.frame.origin.y + containVC.view.frame.height)
        }
        
        menuButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(containVC.view.frame.origin.x)
            make.top.equalTo(containVC.view.frame.origin.y + statusBarHeight)
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
        leftVC.view.animation.makeWidth(space).anchorLeft.animate(0.3)
        rightVC.view.animation.makeX(space).animate(0.3)
    }
}
