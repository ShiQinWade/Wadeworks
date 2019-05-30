//
//  ViewController.swift
//  Map
//
//  Created by WADE on 2019/4/30.
//  Copyright © 2019 WADE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    //建立屬性
    var locationManager : CLLocationManager?
    
    @IBOutlet weak var map: MKMapView!
  //協定的方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     print("------------")
        print("\(locations[0].coordinate.latitude)")
        print("\(locations[0].coordinate.longitude)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //追蹤屬性
        locationManager?.delegate = self
       //設定準確度
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        //設定活動的模式
        locationManager?.activityType = .automotiveNavigation
        // 每次手機移動更新地點資訊，就可以觸發協定的方法
        locationManager?.startUpdatingLocation()
        //追蹤使用者模式
        map.userTrackingMode = .followWithHeading
        
            locationManager = CLLocationManager()
    //請求使用者授權
        locationManager?.requestWhenInUseAuthorization()
           //把得知使用者的座標存進coordinate
        if let coordinate = locationManager?.location?.coordinate{
        let xScale :CLLocationDegrees = 0.01
        let yScale :CLLocationDegrees = 0.01
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
           let region = MKCoordinateRegion.init(center: coordinate, span: span)
            map.setRegion(region, animated: true)
    }
        
    }
    //如果離開畫面結束生命週期，不想繼續更新畫面
    override func viewDidDisappear(_ animated: Bool) {
       //停止更新資訊
    locationManager?.stopUpdatingLocation()
    }
}


