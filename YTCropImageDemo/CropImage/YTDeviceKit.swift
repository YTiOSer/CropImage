//
//  YTDeviceKit.swift
//  YTCropImageDemo
//
//  Created by yangtao on 2018/5/11.
//  Copyright © 2018年 qeegoo. All rights reserved.
//

import UIKit

//open表示当前类、属性或者方法可以在任何地方被继承或者override；
open class YTDeviceKit: NSObject {

    fileprivate static let instance = YTDeviceKit()
    class func shareInstance() -> YTDeviceKit { return instance }
    /**
     打电话
     
     - parameter phone: 手机号
     */
    open func qgCallPhone(_ phone: String) {
        
        guard let url = URL(string: "tel://" + phone) else{return}
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options:[:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
    }
    
}

public var Orientation: UIInterfaceOrientation {
    get {
        return UIApplication.shared.statusBarOrientation
    }
}

/// 屏幕宽度
public var ScreenWidth: CGFloat {
    get {
        if UIInterfaceOrientationIsPortrait(Orientation) {
            return UIScreen.main.bounds.size.width
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
}

/// 屏幕高度
public var ScreenHeight: CGFloat {
    get {
        if UIInterfaceOrientationIsPortrait(Orientation) {
            return UIScreen.main.bounds.size.height
        } else {
            return UIScreen.main.bounds.size.width
        }
    }
}

/// 状态栏高度
public var StatusBarHeight: CGFloat {
    get {
        return UIApplication.shared.statusBarFrame.height
    }
}

