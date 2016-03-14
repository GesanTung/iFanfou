//
//  GTLocationAction.swift
//  GTMobile
//
//  Created by tung on 16/3/10.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit
import CoreLocation

class GTLocationAction: GTAction,CLLocationManagerDelegate {
    let locationManager:CLLocationManager = CLLocationManager()
    
    override func execute(){
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        //let currLocation:CLLocation = locations.last!
        self.done(locations)
    }

}
