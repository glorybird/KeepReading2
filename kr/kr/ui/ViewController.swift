//
//  ViewController.swift
//  kr
//
//  Created by FanFamily on 16/1/20.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var builder:SideMenuBuilder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuVC:MenuViewController = MenuViewController()
        let readListVC:ReadListViewController = ReadListViewController()
        let menuButton:UIButton = UIButton(type: UIButtonType.System)
        menuButton.frame = CGRectMake(0, 0, 50, 50)
        menuButton.setTitle("...", forState: UIControlState.Normal)
        builder = SideMenuBuilder(containVC: self, leftVC: menuVC, rightVC: readListVC, menuButton:menuButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        builder!.build()
    }
}

