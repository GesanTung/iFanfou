//
//  GTShareAction.swift
//  GTMobile
//
//  Created by tung on 16/3/10.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class GTShareAction: GTAction {

    override func execute(){
        self.share()
    }
    
    func share(){
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        
        let images:[String]?
        if let url = dict!.valueForKeyPath("photo.thumburl") as? String {
            images = [url]
        }else{
            images = [""]
        }
        
        shareParames.SSDKSetupShareParamsByText(dict!["text"] as? String,
            images : images,
            url : NSURL(string:"http://fanfou.com"),
            title : "",
            type : SSDKContentType.Text)
        
        
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParames) { (state, platformType, userData, contentEntity, error, end) -> Void in
            switch state{
                
            case SSDKResponseState.Success:
                
                let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "确定 ")
                alert.show()
                self.done(userData)
            case SSDKResponseState.Fail: break
            case SSDKResponseState.Cancel: break
                
            default:
                break
            }
        }
        
    }
}
