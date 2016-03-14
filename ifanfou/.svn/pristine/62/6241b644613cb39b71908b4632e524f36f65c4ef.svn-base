//
//  ZYTabBarController.swift
//  GTMobile
//
//  Created by 张宇 on 16/1/20.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class ZYTabBarController: UITabBarController, ZYTabBarDelegate {
    //  所有控制器配置信息数组 (控制器名称，tabBar两张图，tabBar标题)
    var dictInfoArray:[AnyObject]!{
        didSet {
            initTabBar()
        }
    }
    
    var customTabBar = ZYTabBar()  // 自定义tabBar
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //TODO 初始化cell 内容
    func initTabBar(){
        // 添加子控制器
        for dict in dictInfoArray as! [[String : AnyObject]]
        {
            addOneChildViewController(dict["class"] as! String, icon: dict["icon"] as! String, selIcon: dict["icon_s"] as! String, title: dict["title"] as! String)
        }
        // 添加自定义tabBar
        customTabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        customTabBar.delegate = self
        tabBar.addSubview(customTabBar)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for child:UIView in tabBar.subviews
        {
            if child.isKindOfClass(UIImageView) || child.isKindOfClass(UIControl)
            {
                // 移除一根莫名其妙的imageView 系统自带的UITabBarItem
                child.removeFromSuperview()
            }
        }
    }
    
    // 初始化一个控制器，并且创建一个自定义tabBarItem
    private func addOneChildViewController(childVCName: String, icon: String, selIcon: String, title: String) {
        // 1.动态获取命名空间 初始化控制器
        let namespace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"]
        let className = (namespace as?String)! + "." + childVCName
        let VC = NSClassFromString(className) as! BaseViewController.Type
        let controller = VC.init()
        // 2.创建一个自定义tabBarItem
        customTabBar.addOneTabBarItem(icon, selIcon: selIcon, title: title)
        // 2.包导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(controller)
        // 3.添加控制器到tabbarVC
        addChildViewController(nav)
    }
    
    func tabBarDidClickFromIndexToIndex(tabBar: ZYTabBar, oldIndex: Int, newIndex: Int) {
        selectedIndex = newIndex
    }
}
