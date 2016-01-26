//
//  KrCollectionViewCell.swift
//  kr
//
//  Created by FanFamily on 16/1/26.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class KrCollectionViewCell: UICollectionViewCell {
    
    var progressView:UIView?
    
    var atDown:Bool?
    
    func build() {
        if progressView != nil {
            progressView!.removeFromSuperview()
        }
        progressView = UIView(frame:CGRectMake(10, 10, frame.width - 20, frame.height - 20))
        progressView!.backgroundColor = UIColor.yellowColor()
        addSubview(progressView!)
        clipsToBounds = false
        atDown = false
    }
    
    func down() {
        if atDown == true {
            return
        }
        atDown = true
        progressView!.animation.moveY(frame.size.height).bounce.animate(1.0)
        
    }
}
