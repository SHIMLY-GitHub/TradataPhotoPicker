//
//  TradataPhotoPickerExtension.swift
//  TradataPhotoPicker
//
//  Created by 董家祎 on 2018/9/15.
//  Copyright © 2018年 djy. All rights reserved.
//

import Foundation
import UIKit
extension TradataPhotoPickerController{
    
    
    func stupCollectionView() -> Void {
        let layout = UICollectionViewFlowLayout()
        
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        
        collectionView.delegate   = self
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(TradataPhotoCollectionCell.self, forCellWithReuseIdentifier: "TradataPhotoCollectionCell")
         self.view.addSubview(collectionView)
       
        
        
    }
    func collectionViewPosition() -> Void {
        guard tradataPhotoProtocol == nil else {
            
            if tradataPhotoProtocol?.tradataPosition == TradataPosition.bottom {
                collectionView.scrollToItem(at: IndexPath(item: tdFetchResult!.phFetchResult.count-1, section: 0), at: .bottom, animated: false)
            }
            return
        }
        
      collectionView.scrollToItem(at: IndexPath(item: tdFetchResult!.phFetchResult.count-1, section: 0), at: .bottom, animated: false)
    }
    
    func initNavigation() -> Void {
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.barTintColor = tradataNavProtocol != nil ? tradataNavProtocol?.tradataBarTintColor : UIColor(red: 0, green: 0, blue: 0, alpha:1);
        
    
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: tradataNavProtocol != nil ? tradataNavProtocol?.tardataTitleThemeColor as Any : UIColor.white]
        
        if tradataNavProtocol == nil {
            self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        }else{
            self.navigationController?.navigationBar.barStyle = tradataNavProtocol?.tradataStatusBarStyle == TradataStatusBarStyle.white ? UIBarStyle.black : UIBarStyle.default
        }
        
        self.gobackStyle()
        
        self.tradataRightStyle()
        
    }
    
    func tradataRightStyle() -> Void {
     
      
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(tradataRightButtonAction))
        
    }
    
    func gobackStyle() -> Void {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Bundle.tradata_goback, style: UIBarButtonItemStyle.plain, target: self, action: #selector(gobackAction))
        
        self.navigationController?.navigationBar.tintColor = tradataNavProtocol != nil ? tradataNavProtocol?.tardataTitleThemeColor:UIColor.white
        
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        

    }
    
   @objc func tradataRightButtonAction() -> Void {
          self.navigationController?.dismiss(animated: true, completion: nil)
    }
    @objc func gobackAction() -> Void {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}


