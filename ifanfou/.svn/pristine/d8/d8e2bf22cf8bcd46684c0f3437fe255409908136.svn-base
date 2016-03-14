//
//  GTService.swift
//  GTMobile
//
//  Created by tung on 16/3/7.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

@objc protocol GTActionInterface{
    func execute()
    func cancel()
    func done(obj:AnyObject)
}

@objc protocol GTServiceDelegate{
    func actionDidSuccess(action:GTAction)
    func actionDidFailed(action:GTAction)
}

typealias ActionBlock = (AnyObject) -> ()

class GTAction: NSObject,GTActionInterface {
    
    internal var dict: AnyObject?
    
    internal var block : ActionBlock?
    
    internal var delegate : GTServiceDelegate?
    
    func execute(){
    
    }
    
    class func action (dict: AnyObject,completeBlock:ActionBlock) {
//        let className = "\(self)"
//        let action = GTAction()
//        
//        var instance: AnyObject! = nil
//        let classInst = ClassFromString(className)
//        instance = classInst() // create the instance from this class
//        
//        print(className)
//        let classType = NSClassFromString(className) as? GTAction.Type
//        if let type = classType {
//            let my = type.init()
//           
//        }
//
//        action.dict = dict
//        GTActionManage.sharedInstance.excuteAction(action, completeBlock: completeBlock)
    }
    
    func cancel(){
        self.delegate = nil;
        self.block = nil;
    }
    func done(obj:AnyObject){
        if let exsistblock = block
        {
            exsistblock(obj) //无参无返回
        }
        self.block = nil;
        
        GTActionManage.sharedInstance.actionQueue.removeObject(self)
    }
}
