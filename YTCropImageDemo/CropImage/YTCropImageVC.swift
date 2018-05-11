//
//  QGCropImageVC.swift
//  B2BAutoziMall
//
//  Created by YTiOSer on 18/4/16.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit
import SnapKit

typealias clickBtnClouse = () -> Void //取消闭包
typealias getCropImageClosure = (UIImage) -> Void //裁剪闭包

let kScreenW = ScreenWidth //屏幕宽(适配横竖屏)
let kScreenH = ScreenHeight //屏幕高(适配横竖屏)
let kNavigationBarHei:CGFloat = 64.0 + (UIDevice.current.isX() == true ? 24.0 : 0) //导航栏高(适配iPhone X)

class YTCropImageVC: UIViewController {

    private var originalImageView: YTImageView!
    var originalImage:UIImage?
    var didClickedCancelButtonClosure: clickBtnClouse?
    var didClickedOKButtonClosure: getCropImageClosure?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: 事件
extension YTCropImageVC {
    
    // MARK: -处理按钮点击事件
    /**
     - Parameters:
     - btn: UIButton
     */
    
    @objc func didClickedButtonAction(btn: UIButton) {
        
        switch btn.tag {
        case 1000:
            if let sureClosure = didClickedCancelButtonClosure {
                sureClosure()
            }
            self.dismiss(animated: true, completion: nil)
        case 2000:
            let img = originalImageView.currentCroppedImage()
            self.dismiss(animated: true, completion: nil)
            if  img != nil {
                didClickedOKButtonClosure!(img!)
            }
        default :
            break
        }
    }
    
}

// MARK: UI
extension YTCropImageVC{
    
    private func setupLayout () {
        
        self.view.backgroundColor = UIColor.black
        let toolbar = UIView()
        toolbar.backgroundColor = UIColor.gray
        toolbar.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kNavigationBarHei)
        self.view.addSubview(toolbar)
        
        let btnCancel = UIButton(type: UIButtonType.custom)
        btnCancel.setTitle("取 消", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        btnCancel.backgroundColor = UIColor.clear
        btnCancel.addTarget(self, action: #selector(YTCropImageVC.didClickedButtonAction(btn:)), for: .touchUpInside)
        btnCancel.tag = 1000
        btnCancel.frame = CGRect(x: 5, y: kNavigationBarHei - 34, width: 80, height: 20)
        toolbar.addSubview(btnCancel)
        
        let buttonOK = UIButton(type: UIButtonType.custom)
        buttonOK.setTitle("完 成", for: .normal)
        buttonOK.setTitleColor(UIColor.green, for: .normal)
        buttonOK.backgroundColor = UIColor.clear
        buttonOK.addTarget(self, action: #selector(YTCropImageVC.didClickedButtonAction(btn:)), for: .touchUpInside)
        buttonOK.tag = 2000
        buttonOK.frame = CGRect(x: kScreenW - 80, y: kNavigationBarHei - 34, width: 80, height: 20)
        toolbar.addSubview(buttonOK)
        
        
        originalImageView = { [unowned self] in
            
            let imageView = YTImageView()
            if self.originalImage != nil  {
                imageView.toCropImage = self.originalImage
            }
            
            imageView.showMidLines = true
            imageView.needScaleCrop = true
            imageView.showCrossLines = true
            imageView.cornerBorderInImage = false
            imageView.cropAreaCornerWidth = 14
            imageView.cropAreaCornerHeight = 14
            imageView.minSpace = 1//最小间距
            
            imageView.cropAreaCornerLineColor = UIColor.green
            imageView.cropAreaBorderLineColor = UIColor.green
            imageView.cropAreaCornerLineWidth = 3 //角宽
            imageView.cropAreaBorderLineWidth = 1
            
            imageView.cropAreaMidLineWidth = 14
            imageView.cropAreaMidLineHeight = 3
            imageView.cropAreaMidLineColor = UIColor.green
            imageView.cropAreaCrossLineColor = UIColor.green
            imageView.cropAreaCrossLineWidth = 1
            imageView.initialScaleFactor = 0.7
            
            //设置边框线的颜色
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(kNavigationBarHei)
                make.width.equalTo(kScreenW)
                make.height.equalTo(kScreenH - kNavigationBarHei)
            }
            return imageView
            }()
        
    }
    
}

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}
