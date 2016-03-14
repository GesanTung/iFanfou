//
//  UIMediaViewController.swift
//  GTMobile
//
//  Created by tung on 16/2/18.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class UIDiscoverViewController: BaseViewController,BaseTableViewDelegate {
    
    var gWMPlayer = WMPlayer()
    
    var gViewContent = BaseTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBarButton(NAV.LEFT, string:"home_navi_left.png")
        setNavBarButton(NAV.RIGHT, string:"home_navi_right.png")
        setNavTitle("发现")
        
        gViewContent.gTableUrl = KURLAppDiscoverTimeLine
        gViewContent.delegate = self;
        gViewContent.gTableAutoHeight = true
        gViewContent.gTableCellName = "FanFouCellView"
        gViewContent.view.frame = CGRectMake(0,0,KScreenWidth,KScreenHeight)
        self.view .addSubview(gViewContent.view)
        addChildViewController(gViewContent)
        
        let nib: UINib = UINib(nibName: "FanFouImageCellView", bundle: NSBundle.mainBundle())
        gViewContent.tableView.registerNib(nib, forCellReuseIdentifier: "FanFouImageCellView")
    }
    
    func tableViewHttpLoadSuccess(tableView:UITableView!,json:AnyObject!)-> [AnyObject]{
        //替换@ A标签
        var gDataSource = [AnyObject]()
        if let JSON :NSArray = json as? NSArray {
            
            for(var index = 0; index < JSON.count ; index++) {
                let temp: NSMutableDictionary = NSMutableDictionary()
                temp.setDictionary(JSON[index] as! [NSObject : AnyObject])
                
                temp["text"] = NSString.getText(JSON[index])
                gDataSource.append(temp)
            }
            
            tprint("JSON: \(JSON)")
        }
       return gDataSource
    }

    func tableViewHeightForRowAtIndexPath(tableView: UITableView!,indexPath: NSIndexPath!,dict:AnyObject!)-> CGFloat{
        let image  = dict["photo"]
        if (image === nil){
            return tableView.dg_heightForCellWithIdentifier("FanFouCellView", indexPath: indexPath,configuration: { (cell) -> Void in
                let cell = cell as! BaseTableViewCell
                cell.gDict = dict
            })
        }else{
            return tableView.dg_heightForCellWithIdentifier("FanFouImageCellView", indexPath: indexPath,configuration: { (cell) -> Void in
                let cell = cell as! BaseTableViewCell
                cell.gDict = dict
            })
        }
        
    }
    
    func tableViewCellForRowAtIndexPath(tableView: UITableView!,indexPath: NSIndexPath!,dict:AnyObject!) -> UITableViewCell!{
        let image  = dict["photo"]
        if (image === nil){
            let cell = tableView.dequeueReusableCellWithIdentifier("FanFouCellView", forIndexPath: indexPath)as!BaseTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.gDict = dict as! NSDictionary
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("FanFouImageCellView", forIndexPath: indexPath)as!BaseTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.gDict = dict as! NSDictionary
            return cell
        }
    }
    
    func tableViewDidSelectRowAtIndexPath(tableView: UITableView!,indexPath: NSIndexPath!,dict:AnyObject!){
        let controller = UIDetailVController()
        controller.gDict = dict as? Dictionary<String,AnyObject>
        pushViewController(controller,animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
