//
//  HRCollectionViewController.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/19.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class HRCollectionViewController: UIViewController {
    
    var collection:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing=0;
        layout.minimumLineSpacing=0;
        layout.itemSize=CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height);
        layout.scrollDirection=UICollectionViewScrollDirection.Horizontal;
        layout.headerReferenceSize=CGSizeZero;
        layout.footerReferenceSize=CGSizeZero;
        
        collection = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.view.addSubview(collection)
//        collection.delegate = self
//        collection.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
