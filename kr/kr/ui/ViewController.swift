//
//  ViewController.swift
//  kr
//
//  Created by FanFamily on 16/1/20.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SideMenuBuilderDelegate {

    var readListVC:ReadListViewController?
    
    var builder:SideMenuBuilder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuVC:MenuViewController = MenuViewController()
        readListVC = ReadListViewController()
        let menuButton:UIButton = UIButton(type: UIButtonType.System)
        menuButton.frame = CGRectMake(0, 0, 50, 50)
        menuButton.setTitle("...", forState: UIControlState.Normal)
        builder = SideMenuBuilder(containVC: self, leftVC: menuVC, rightVC: readListVC!, menuButton:menuButton)
        builder!.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        builder!.build()
    }
    
    func willChangeLeftSpace(space: CGFloat) {
        if space == 0 {
            self.readListVC!.collectionView.frame.size.width = self.readListVC!.view.frame.width
        }
    }
    
    func didChangeLeftSpace(space: CGFloat) {
        if space > 0 {
            self.readListVC!.collectionView.frame.size.width = self.readListVC!.view.frame.width - space
        }
    }
}

