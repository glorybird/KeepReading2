//
//  ProgressView.swift
//  kr
//
//  Created by FanFamily on 16/1/30.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        print("击中了progressView")
        return view
    }
    
}
