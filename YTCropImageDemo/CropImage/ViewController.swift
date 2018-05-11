//
//  ViewController.swift
//  YTCropImageDemo
//
//  Created by YTiOSer on 18/4/16.
//  Copyright © 2018 YTiOSer. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    fileprivate var img_Show: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func cameraAlbumBtnClick() {
        // MARK: 判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let vc_ImagePicker = UIImagePickerController()
            vc_ImagePicker.delegate = self
            vc_ImagePicker.sourceType = .photoLibrary
            vc_ImagePicker.allowsEditing = true
            self.present(vc_ImagePicker, animated: true) {
                
            }
        }else{
            print("读取相册失败")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            picker.dismiss(animated: true, completion: nil)
            cropImage(img: image)
        }
        
    }
  
    func cropImage(img: UIImage) {
        
        let vc = YTCropImageVC()
        vc.originalImage = img;
        self.present(vc, animated: true, completion: nil)
        vc.didClickedCancelButtonClosure = { [unowned self] in
            self.img_Show.image = img
        }
        vc.didClickedOKButtonClosure = { [unowned self] (image: UIImage) in
            self.img_Show.image = img
        }
        
    }
    
}


extension ViewController{
    
    func initMainView() {
        
        let btn_Camera = UIButton.init(type: .custom)
        btn_Camera.setTitle("相册", for: .normal)
        btn_Camera.setTitleColor(UIColor.orange, for: .normal)
        btn_Camera.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn_Camera.layer.borderColor = UIColor.orange.cgColor
        btn_Camera.layer.borderWidth = 1
        btn_Camera.addTarget(self, action: #selector(cameraAlbumBtnClick), for: .touchUpInside)
        view.addSubview(btn_Camera)
        btn_Camera.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(kNavigationBarHei + 30)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        img_Show = UIImageView()
        img_Show.layer.borderColor = UIColor.gray.cgColor
        img_Show.layer.borderWidth = 1
        view.addSubview(img_Show)
        img_Show.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(kScreenW * 0.7)
            make.height.equalTo(kScreenH * 0.6)
        }
        
    }
    
}

