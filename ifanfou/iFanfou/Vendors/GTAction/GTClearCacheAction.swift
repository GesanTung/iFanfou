//
//  GTClearCacheAction.swift
//  GTMobile
//
//  Created by tung on 16/3/10.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

public let kCachePath      = ""

class GTClearCacheAction: GTAction {
    override func execute(){
        var directory: ObjCBool = ObjCBool(false)
        let exists: Bool = NSFileManager.defaultManager().fileExistsAtPath(kCachePath, isDirectory: &directory)
        
        if exists {
            try! NSFileManager.defaultManager().removeItemAtPath(kCachePath)
            self.performSelector(Selector("done"), withObject:nil)
        }else{
           tprint("cache directory not found")
        }
    }
}
