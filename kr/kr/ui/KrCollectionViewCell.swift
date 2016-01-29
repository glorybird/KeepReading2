//
//  KrCollectionViewCell.swift
//  kr
//
//  Created by FanFamily on 16/1/26.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

@objc protocol KrCollectionViewCellDelegate {
    optional func didDownProgressView(cell:KrCollectionViewCell)
    optional func didUpProgressView(cell:KrCollectionViewCell)
}

enum ProgressStatus {
    case Normal
    case DownSide
}


class KrCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var progressView: UIView!
    
    var delegate:KrCollectionViewCellDelegate?
    
    var status:ProgressStatus = ProgressStatus.Normal
    
    @IBAction func downProgressView(sender: AnyObject) {
        if status == ProgressStatus.Normal {
            progressView!.animation.moveY(frame.size.height).bounce.animate(0.6)
            if delegate != nil {
                delegate!.didDownProgressView!(self)
            }
            status = ProgressStatus.DownSide
        } else {
            progressView!.animation.moveY(-frame.size.height).animateWithCompletion(0.3, { () -> Void in
                if self.delegate != nil {
                    self.delegate!.didUpProgressView!(self)
                }
                self.status = ProgressStatus.Normal
            })
        }
    }
    
    func resetToNornalStatus() {
        if status == ProgressStatus.Normal {
            return
        }
        
        progressView!.center = CGPointMake(progressView!.center.x, progressView!.center.y - frame.size.height)
        self.status = ProgressStatus.Normal
        
    }
}
