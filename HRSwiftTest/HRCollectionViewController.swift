//
//  HRCollectionViewController.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/19.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class HRCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var collection:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("backLast"))
        
        self.view.backgroundColor = UIColor.whiteColor()
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing=0;
        layout.minimumLineSpacing=0;
        layout.itemSize=CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height);
        layout.scrollDirection=UICollectionViewScrollDirection.Vertical;
        layout.headerReferenceSize=CGSizeZero;
        layout.footerReferenceSize=CGSizeZero;
        
        collection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.registerClass(HRCollectionCell.classForCoder(), forCellWithReuseIdentifier: "myCollectionCell")
        collection.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func backLast(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:HRCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("myCollectionCell", forIndexPath: indexPath) as! HRCollectionCell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.size.width/2 - 1
        return CGSizeMake(width + 0.5, width - 0.5)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
