//
//  AppDelegate.swift
//  GTMobile
//
//  Created by tung on 16/1/8.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BaseNetServerDelegate {

    var window: UIWindow?
    
    var navigationController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: KScreenSize)
        
        let net = BaseNetService()
        
        net.delegate = self;
        net.HttpGet(KURLAPPLayout)
        return true
    }
    
    func httpRequestSsuccess(url: String,data:NSDictionary,status:HTTPStatus){
        if status == HTTPStatus.HTTPStatuSsuccess{
           applicationDidLayout(data)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate{
    // MARK: - APP 框架布局
    func applicationDidLayout(data:NSDictionary){
        let list = data.objectForKey("datas") as! [AnyObject]
        
        let tabBarController = ZYTabBarController()
        tabBarController.dictInfoArray = list
        
        let slideMenuController = UISlideViewController()
        
        slideMenuController.slide(tabBarController, leftMenuViewController: LeftViewController())
        //navigationController = UINavigationController(rootViewController: slideMenuController)
        self.window?.rootViewController = slideMenuController
        
        self.applicationDidRegisterService()
        
        GTShareAction.action(list) { (obj) -> () in
            
        }
    
        window?.makeKeyAndVisible()
    }
    

}

extension AppDelegate{
    // MARK: - APP 服务注册
    func applicationDidRegisterService(){
        ShareSDK.registerApp(KAppKeyShareSDK,
            
            activePlatforms: [SSDKPlatformType.TypeWechat.rawValue],
            onImport: {(platform : SSDKPlatformType) -> Void in
                
                switch platform{
                
                    case SSDKPlatformType.TypeWechat:
                        ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    default: break
                }
            },
            onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                switch platform {
                    
                case SSDKPlatformType.TypeWechat:
                    //设置微信应用信息
                    appInfo.SSDKSetupWeChatByAppId(KAppIDWeiXin, appSecret:KAppSecretWeiXin)
                default:
                    break
                    
                }
        })
    }
}
