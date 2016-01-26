//
//  ReadListViewController.swift
//  kr
//
//  Created by FanFamily on 16/1/20.
//  Copyright © 2016年 glorybird. All rights reserved.
//

import UIKit

class ReadListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var count:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = SpringLayout()
        collectionView.registerClass(KrCollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "identifier"
        let cell:KrCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath:indexPath) as! KrCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        cell.build()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    @IBAction func AddCell(sender: AnyObject) {
        let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! KrCollectionViewCell
        cell.down()
        
        let layout:SpringLayout = collectionView.collectionViewLayout as! SpringLayout
        layout.removeAllBehavior()
        layout.installBehaviorsDropDown(0, offset: cell.progressView!.frame.size.height + 10)
    }
}
