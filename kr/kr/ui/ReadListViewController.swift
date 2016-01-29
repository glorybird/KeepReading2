//
//  ReadListViewController.swift
//  kr
//
//  Created by FanFamily on 16/1/20.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class ReadListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, KrCollectionViewCellDelegate, UIScrollViewDelegate, SpringLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var count:Int = 10
    
    var downProgressCell:KrCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        (collectionView as UIScrollView).delegate = self
        collectionView.collectionViewLayout = SpringLayout()
        (collectionView.collectionViewLayout as! SpringLayout).delegate = self
        collectionView.registerNib(UINib(nibName: "KrCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "identifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "identifier"
        let cell:KrCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath:indexPath) as! KrCollectionViewCell
        cell.resetToNornalStatus()
        cell.delegate = self
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func didDownProgressView(cell: KrCollectionViewCell) {
        if downProgressCell != nil {
            downProgressCell!.resetToNornalStatus()
        }
        let index = collectionView.indexPathForCell(cell)
        if index != nil {
            let springLayout = (collectionView.collectionViewLayout as! SpringLayout)
            springLayout.removeAllBehavior()
            springLayout.installBehaviorsDropDown(CGFloat(index!.row), offset:cell.progressView!.frame.size.height + 10)
        }
        downProgressCell = cell
    }
    
    func didUpProgressView(cell: KrCollectionViewCell) {
        let springLayout = (collectionView.collectionViewLayout as! SpringLayout)
        springLayout.removeAllBehavior()
        springLayout.installBehaviors(0.0)
        downProgressCell = nil
    }
    
    func changeToNewBounds(newBounds: CGRect) {
        if downProgressCell != nil {
            downProgressCell!.resetToNornalStatus()
        }
    }
}
