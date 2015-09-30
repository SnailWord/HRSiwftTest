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

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var list:NSMutableArray?
    var items:NSMutableArray?
    var table:UITableView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if list?.count > 0{
            return
        }
        
        SVProgressHUD.showWithStatus("Submitting...", maskType: SVProgressHUDMaskType.Black)
        
        //OC Swift混编使用OC的AFNetwork进行数据请求
        let client:HRApiClient = HRApiClient.client()! as! HRApiClient
                client.getPath("http://zstest.aliapp.com/API/getSceneList", parameters: nil) { (task, responseDic, error) -> Void in
                    print("AF",NSDate.init())
                    print(responseDic)
                }
        
        //新的Almofire swift框架进行请求
        Alamofire.request(.GET, "http://zstest.aliapp.com/API/getSceneList",parameters:nil).response{request, response, data, error in
            print("Swift",NSDate.init())
            do {
                let object:AnyObject! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                //print(object["InfoList"])
                let count = object.objectForKey("InfoList")!.count
                for(var i = 0; i < count;i++){
                    let itemDic:NSDictionary = (object["InfoList"] as! NSArray)[i] as! NSDictionary;
                    let item:HRTestItem = HRTestItem.init(itemDic as! Dictionary<String, AnyObject>)
                    self.list!.addObject(item)
                }
                self.table.reloadData()
                SVProgressHUD.dismiss()
            } catch let aError as NSError {
                if error != nil {
                    print(aError)
                }
            }
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
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCellSeparatorStyle.None
        table.registerClass(HRCustomTableCell.classForCoder(), forCellReuseIdentifier: "myCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doSomeThing(){
//        let collectionVC:HRCollectionViewController = HRCollectionViewController.init()
//        let naVC:UINavigationController = UINavigationController.init(rootViewController: collectionVC)
//        self.presentViewController(naVC, animated: true) { () -> Void in
//            
//        }
        
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
        
        let item:HRTestItem = (self.list?.objectAtIndex(indexPath.row))! as! HRTestItem
        
        cell.title?.text = item.SceneName as? String
        cell.iconImage.sd_setImageWithURL(NSURL.init(string: item.DesignerPicSrc! as String))
        cell.sign.text = item.DesignerPicSrc as? String
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            print("删除")
            self.list?.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}

