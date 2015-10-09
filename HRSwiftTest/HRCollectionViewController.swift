//
//  HRCollectionViewController.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/19.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit
import SVProgressHUD

class HRCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var collection:UICollectionView!
    var datas:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datas = NSMutableArray.init(array: []) as NSMutableArray
        
        
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
        collection.registerClass(MyTalkCollectionReusableView.classForCoder(), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "MyWorkHeader")
        collection.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        let client:HRApiClient = HRApiClient.client()! as! HRApiClient
        client.getAllTalksByPage(1, andPerPage: 5) {(task, responseDic, error) -> Void in
            print(NSStringFromClass(responseDic.classForCoder))
            for dic in (responseDic as! NSArray){
                let myDic:NSDictionary = dic as! NSDictionary
                let work:HRTalkItem  = HRTalkItem.init(dictionary: myDic)
                self.datas.addObject(work)
            }
            self.collection.reloadData()
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
        return self.datas.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let talks:HRTalkItem = self.datas.objectAtIndex(section) as! HRTalkItem
        return (talks.detailMovement?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item:HRTalkItemDetail = (self.datas.objectAtIndex(indexPath.section) as! HRTalkItem).detailMovement?.objectAtIndex(indexPath.row) as! HRTalkItemDetail
        let cell:HRCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("myCollectionCell", forIndexPath: indexPath) as! HRCollectionCell
        cell.avator.sd_setImageWithURL(NSURL.init(string: item.logo! as String))
        cell.bigBkg.sd_setImageWithURL(NSURL.init(string: item.statusUrl! as String))
        cell.title.text = self.getPureString(item.text!) as String
        
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
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header:MyTalkCollectionReusableView = collection.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "MyWorkHeader", forIndexPath: indexPath) as! MyTalkCollectionReusableView
        let item:HRTalkItem = self.datas.objectAtIndex(indexPath.section) as! HRTalkItem
        
        
        header.title.text = item.talkcontent! as String
        return header
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 40)
    }
    
    func getPureString(oriString:NSString)->NSString{
        let range:NSRange = oriString.rangeOfString("#", options: NSStringCompareOptions.BackwardsSearch, range: NSMakeRange(0, oriString.length))
        
        return oriString.substringFromIndex(range.location+1)
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
