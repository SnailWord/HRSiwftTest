//
//  HRPersonalViewController.swift
//  HRSwiftTest
//
//  Created by ZhangHeng on 15/9/29.
//  Copyright © 2015年 ZhangHeng. All rights reserved.
//

import UIKit

class HRPersonalViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HRLocationPickerProtocol {

    var table:UITableView!
    var array:NSArray!
    var locationPicker:HRLocationPicker? 
    var valueDic:NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        array = [["头像","昵称","性别","生日","所在地","座右铭"],["公司","职位"],["个性标签"]]
        
        let keyArr:NSArray = ["头像","昵称","性别","生日","所在地","座右铭","公司","职位","个性标签"]
        valueDic = NSMutableDictionary.init(capacity: 9)
        for key in keyArr{
            if(key as! String == "头像"){
                valueDic.setObject("", forKey: key as! String)
            }else{
                valueDic.setObject("未填写", forKey: key as! String)
            }
        }
        
        self.title = "个人信息"
        
        table = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Grouped)
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        table.registerClass(HRPersonalCell.classForCoder(), forCellReuseIdentifier: "myCell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("Back"))
    }
    
    func Back(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:HRPersonalCell = table.dequeueReusableCellWithIdentifier("myCell") as! HRPersonalCell
        let titleString:String = array[indexPath.section][indexPath.row] as! String
        cell.label.text = titleString
        
        let value:String = valueDic.objectForKey(titleString) as! String
        cell.content.text = value
        
        if(indexPath.row == 0 && indexPath.section == 0){
            cell.avatorImage.sd_setImageWithURL(NSURL.init(string: "http://pic74.nipic.com/file/20150803/21060976_140137957001_2.jpg"))
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 5
        }else{
            return 20
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0 && indexPath.row == 0){
            return 90
        }else{
            return 44
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 4){
            locationPicker = HRLocationPicker.init() 
            self.view.addSubview(locationPicker!)
            locationPicker!.delegate = self
        }
    }
    
    func didSelectLocation(placeString: String!) {
        locationPicker?.removeFromSuperview()
        print(placeString)
        
        valueDic.setObject(placeString, forKey: "所在地")
        table.reloadData()
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
