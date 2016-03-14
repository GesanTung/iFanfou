//
//  GTActionManage.swift
//  GTMobile
//
//  Created by tung on 16/3/10.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class GTActionManage: NSObject {
    
    class var sharedInstance: GTActionManage {
        return Inner.instance
    }
    
    struct Inner {
        static let instance = GTActionManage()
    }
    
    var actionQueue = NSMutableArray()
    
    func excuteAction(action:GTAction,completeBlock:ActionBlock){
        self.actionQueue.addObject(action)
        action.block = completeBlock
        action.execute()
    }
    
    func cancelAction(action:GTAction){
        self.actionQueue.addObject(action)
        action.cancel()
    }
}
