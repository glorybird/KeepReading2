//
//  SpringLayout.swift
//  collectionViewDemo
//
//  Created by FanFamily on 16/1/24.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class SpringLayout: UICollectionViewFlowLayout {
    var animator: UIDynamicAnimator?
    
    var horizontal:Bool = false
    
    override init() {
        super.init()
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    private func configure() {
        animator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        self.itemSize = CGSizeMake(300, 100)
        installBehaviors(0)
    }
    
    func installBehaviors (offset:CGFloat) {
        let contentSize = self.collectionViewContentSize()
        let items = super.layoutAttributesForElementsInRect(CGRectMake(0, 0, contentSize.width, contentSize.height))
        if animator!.behaviors.count == 0 {
            for item in items! {
                let behavior = UIAttachmentBehavior(item: item, attachedToAnchor: CGPointMake(item.center.x + offset, item.center.y))
                behavior.length = 0
                behavior.damping = 0.5
                behavior.frequency = 2.0
                animator!.addBehavior(behavior)
            }
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return animator!.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return animator!.layoutAttributesForCellAtIndexPath(indexPath)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        guard let collectionView = self.collectionView else {
            
            return false
        }
        
        let contentOffset = collectionView.contentOffset.y
        let contentSize = collectionView.contentSize.height
        let collectionViewSize = collectionView.bounds.size.height
        
        let horizontalDistance = newBounds.width - collectionView.bounds.width
        if horizontalDistance != 0 {
            horizontal = true
            animator!.removeAllBehaviors()
            installBehaviors(horizontalDistance/2)
        } else if horizontal == true {
            horizontal = false
            animator!.removeAllBehaviors()
            installBehaviors(0)
        }

        if 0 <= contentOffset && contentOffset + collectionViewSize <= contentSize {
            
            self.adjustItemCenterFolowingTouchLocation(newBounds: newBounds)
        }
        
        return false
    }
    
    private func adjustItemCenterFolowingTouchLocation(newBounds newBounds: CGRect) {
        
        guard let collectionView = self.collectionView else {
            
            return
        }
        
        let scrollDistance = newBounds.origin.y - collectionView.bounds.origin.y
        
        
        let touchLocation = collectionView.panGestureRecognizer.locationInView(collectionView)
        
        for behavior in animator!.behaviors {
            
            if let behavior = behavior as? UIAttachmentBehavior, let item = behavior.items.first {
                let distanceFromTouch = fabs(touchLocation.y - item.center.y)
                let scrollResistance = distanceFromTouch / 300.0
                let offset = scrollDistance * scrollResistance
                item.center.y += offset
                animator!.updateItemUsingCurrentState(item)
            }
        }
    }
}
