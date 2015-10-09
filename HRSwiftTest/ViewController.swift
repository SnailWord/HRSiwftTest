//
//  ViewController.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/11.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

//24 122 180

import UIKit
import Alamofire
import SVProgressHUD

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    var list:NSMutableArray?
    var items:NSMutableArray?
    var table:UITableView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if list?.count > 0{
            return
        }
        
        SVProgressHUD.showWithStatus("请稍后...", maskType: SVProgressHUDMaskType.Black)
        
        //OC Swift混编使用OC的AFNetwork进行数据请求
        let client:HRApiClient = HRApiClient.client()! as! HRApiClient
        client.getHomePageDreamWithCompletion { (task, responseDic, error) -> Void in
            print(responseDic)
            if(responseDic.isKindOfClass(NSArray.classForCoder())){
                let count = (responseDic as! NSArray).count
                for(var i = 0; i < count;i++){
                    let itemDic:NSDictionary = responseDic.objectAtIndex(i) as! NSDictionary
                    let dreamItem:HRDreamItem = HRDreamItem.init(dictionary: itemDic as! Dictionary<String, AnyObject>)
                    self.list!.addObject(dreamItem)
                }
                self.table.reloadData()
            }
            
            SVProgressHUD.dismiss()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        list = NSMutableArray.init(array: []) as NSMutableArray
        
        let btn:UIButton = UIButton(type: UIButtonType.RoundedRect)
        btn.frame = CGRectMake(20, 60, 60, 30)
        btn.setTitle("presentView", forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: NSSelectorFromString("doSomeThing"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        table = UITableView(frame: CGRectMake(0, 90, self.getScreenSize().width, self.getScreenSize().height-90), style: UITableViewStyle.Plain)
        self.view.addSubview(table!)
        table.separatorStyle = UITableViewCellSeparatorStyle.None
        table.delegate = self
        table.dataSource = self
        table.registerClass(HRCustomTableCell.classForCoder(), forCellReuseIdentifier: "myCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doSomeThing(){
        let user:HRPersonalViewController = HRPersonalViewController.init()
        let nav:UINavigationController = UINavigationController.init(rootViewController: user)
        self.presentViewController(nav, animated: true) { () -> Void in
            
        }
    }
    
    func getScreenSize()->CGSize{
        return UIScreen.mainScreen().bounds.size
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:HRCustomTableCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! HRCustomTableCell
        
        let item:HRDreamItem = (self.list?.objectAtIndex(indexPath.row))! as! HRDreamItem
        
        cell.title?.text = item.fundingText as? String
        cell.bgImage.sd_setImageWithURL(NSURL.init(string: item.logo! as String))
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: item.fundingUrl! as String))
        cell.sign.text = item.nick as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 215
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.list?.count)!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let collection:HRCollectionViewController = HRCollectionViewController.init()
        let nav:UINavigationController = UINavigationController.init(rootViewController: collection)
        self.presentViewController(nav, animated: true) { () -> Void in
            
        }

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let cells:NSArray = self.table.visibleCells
        for cell in cells{
            let yOffset:CGFloat = ((self.table.contentOffset.y - cell.frame.origin.y) / 238) * 20
            let frame:CGRect = (cell as! HRCustomTableCell).bgImage.bounds;
            let offsetFrame:CGRect = CGRectOffset(frame, 0, yOffset);
             (cell as! HRCustomTableCell).bgImage.frame = offsetFrame;
        }
        
    }
}

