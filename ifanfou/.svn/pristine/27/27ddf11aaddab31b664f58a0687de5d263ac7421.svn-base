//
//  UIHtmlDetailVController.swift
//  GTMobile
//
//  Created by tung on 16/1/15.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class UIHtmlDetailVController: BaseViewController,UIWebViewDelegate {
    
    var gViewWebViewContent = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func initContentView() {
        gViewWebViewContent.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight)
        if let url = (gDict["url"] as? String) {
            gViewWebViewContent.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
            gViewWebViewContent.delegate=self
            view .addSubview(gViewWebViewContent)
            setNavBarButton(NAV.LEFT, string:"返回")
            setNavBarButton(NAV.RIGHT, string:"分享")
            setNavTitle("首页")
        }

    }
    

}
