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
    
    @IBOutlet weak var progressView: ProgressView!
    
    @IBOutlet weak var cutView: CupView!
    
    
    @IBOutlet weak var sliderInProgressView: UISlider!
    
    @IBOutlet weak var stepperInProgressView: UIStepper!
    
    
    var delegate:KrCollectionViewCellDelegate?
    
    var status:ProgressStatus = ProgressStatus.Normal
    
    var running:Bool = false
    
    override func awakeFromNib() {
        cutView.changeProgress(1 - CGFloat(sliderInProgressView.value))
    }
    
    @IBAction func downProgressView(sender: AnyObject) {
        if running == true {
            return
        }
        
        running = true
        if status == ProgressStatus.Normal {
            progressView!.animation.moveY(frame.size.height).bounce.animateWithCompletion(0.6, { () -> Void in
                self.running = false
            })
            if delegate != nil {
                delegate!.didDownProgressView!(self)
            }
            status = ProgressStatus.DownSide
        } else {
            progressView!.animation.moveY(-frame.size.height).animateWithCompletion(0.3, { () -> Void in
                self.running = false
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
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if self.status == ProgressStatus.DownSide {
            let progressViewFrame = convertRect(progressView.frame, toView: self)
            let inside = CGRectContainsPoint(progressViewFrame, point)
            if inside == true {
                return progressView.hitTest(convertPoint(point, toView:progressView), withEvent: event)
            } else {
                return super.hitTest(point, withEvent: event)
            }
        } else {
            return super.hitTest(point, withEvent: event)
        }
    }
    @IBAction func sliderChangeValue(sender: AnyObject) {
        cutView.changeProgress(1 - CGFloat(sliderInProgressView.value))
    }
}
