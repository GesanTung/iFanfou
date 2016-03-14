//
//  GTTabBarController.swift
//  GTMobile
//
//  Created by 张宇 on 16/1/19.
//  Copyright © 2016年 GT. All rights reserved.
//

import Foundation
import UIKit

class GTTabBarController: UITabBarController {
    // 存放关于tabBar图标 子控制器名称的 字典数组
    var tabBarInfo:[AnyObject]?
    var tintColor = UIColor.orangeColor()  // tabBar文字颜色
    
//    internal func setupTabBarItemTextColor(norColor:UIColor?, selColor:UIColor?){
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: norColor!], forState:UIControlState.Normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selColor!], forState: UIControlState.Selected)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tabBarInfo)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 初始化tabBar子控件
        for dict in tabBarInfo as! [[String : AnyObject]]
        {
            addOneChildViewController(dict["class"] as! String, icon: dict["icon"] as! String, selIcon: dict["icon_s"] as! String, title: dict["title"] as! String)
        }
    }
    
    // 初始化tabBar子控件
    private func addOneChildViewController(childVCName: String, icon: String, selIcon: String, title: String) {
        // 1.动态获取命名空间 初始化控制器
        let namespace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"]
        let className = (namespace as?String)! + "." + childVCName
        let VC = NSClassFromString(className) as! BaseViewController.Type
        let controller = VC.init()
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(named: icon)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named: selIcon)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        // tabBar文字颜色
        tabBar.tintColor = tintColor
        // 2.包导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(controller)
        // 3.添加控制器到tabbarVC
        addChildViewController(nav)
    }
}
