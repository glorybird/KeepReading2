//
//  CupView.swift
//  kr
//
//  Created by FanFamily on 16/1/31.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class CupView: UIView {
    
    var waveView: SCSiriWaveformView!
    
    var level:CGFloat = 0.1
    
    var dampTimer:NSTimer?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        waveView = SCSiriWaveformView()
        waveView.backgroundColor = UIColor.whiteColor()
        waveView.waveColor = UIColor.orangeColor()
        waveView.primaryWaveLineWidth = 2.0
        waveView.secondaryWaveLineWidth = 0.0
        waveView.idleAmplitude = 0.0
        waveView.density = 1.0
        addSubview(waveView)
        waveView.snp_makeConstraints { (make) -> Void in
            make.margins.equalTo(self).offset(0)
        }
        
        let displaylink = CADisplayLink(target: self, selector:Selector.init("updateWave"))
        displaylink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func updateWave() {
        if level >= 0 {
            waveView.updateWithLevel(level)
        }
    }
    
    func damping() {
        level -= 0.01
        if level < 0 {
            if dampTimer != nil {
                dampTimer!.invalidate()
                dampTimer = nil
            }
        }
    }
    
    func changeProgress(progress:CGFloat) {
        waveView.stage = progress
        level = 0.1
        // 自然衰减
        if dampTimer != nil {
            dampTimer!.invalidate()
        }
        dampTimer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector.init("damping"), userInfo: nil, repeats: true)
    }
}
