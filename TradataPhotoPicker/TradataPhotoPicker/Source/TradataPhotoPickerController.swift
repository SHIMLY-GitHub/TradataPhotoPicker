//
//  TradataPhotoPickerController.swift
//  TradataPhotoPicker
//
//  Created by 董家祎 on 2018/9/15.
//  Copyright © 2018年 djy. All rights reserved.
//

import UIKit

class TradataPhotoPickerController: UIViewController {
    

    let itemWidth = (UIScreen.main.bounds.size.width-3) / 4.0
    
    var tradataNavProtocol:TradataNavProtocol?
    
    var tradataPhotoProtocol:TradataPhotoProtocol?
    
    
    var collectionView:UICollectionView!
    var tdManager:TradataPhotoManager!
    
    var tdFetchResult:TDFetchResult?
    
    deinit {
        print("释放")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "所有照片"
        self.initNavigation()
        self.stupCollectionView()
        tdManager = TradataPhotoManager(photoProtocol: tradataPhotoProtocol)
        self.reloadPhoto()
    }
    
    func reloadPhoto() -> Void {
  
       
        weak var weakSelf = self
        
        tdManager.ansyFetchResults { (dataSource) in
            weakSelf?.tdFetchResult = dataSource.first
            weakSelf?.collectionView.reloadData()
            weakSelf?.collectionViewPosition()
        }
        
    }


}

extension TradataPhotoPickerController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if tdFetchResult == nil {
            return 0
        }
        return tdFetchResult!.phFetchResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TradataPhotoCollectionCell", for: indexPath) as! TradataPhotoCollectionCell
        
  
        tdManager.libraryThumbnail(index: indexPath.row, assetsFetch: (tdFetchResult?.phFetchResult)!, thumbSize: CGSize(width: itemWidth, height: itemWidth)) { (image, asset) in
       
            cell.imageView.image = image
            
        }
    
        return  cell
        
    }
}

extension TradataPhotoPickerController{
    
    static  func tradataPhotoPicker(controller:UIViewController) -> Void {
        
        let tradata = TradataPhotoPickerController()
        
        tradata.tradataNavProtocol = controller as? TradataNavProtocol
        
        tradata.tradataPhotoProtocol = controller as? TradataPhotoProtocol
        
        let navigation = UINavigationController(rootViewController: tradata)
    
        
            controller.present(navigation, animated: true, completion: nil)
        
    }
   
 
    
}
