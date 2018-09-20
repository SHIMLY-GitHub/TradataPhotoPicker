//
//  TradataPhotoManager.swift
//  TradataPhotoPicker
//
//  Created by 董家祎 on 2018/9/16.
//  Copyright © 2018年 djy. All rights reserved.
//

import Foundation
import Photos

struct TDFetchResult {
    var title:String!
    var phFetchResult:PHFetchResult<PHAsset>!
    
    
    init(title:String,result:PHFetchResult<PHAsset>) {
        self.title = title
        self.phFetchResult = result
    }
}

class TradataPhotoManager {
    
    var ascending:Bool = true
  
    var isContainImage:Bool = true

    
    var isContainVideo:Bool = true
    
    private var result:[TDFetchResult] = []
    
    private  let imageManager:PHCachingImageManager = PHCachingImageManager()
    
    private let thumbOption:PHImageRequestOptions = PHImageRequestOptions()
    
    
    init(photoProtocol:TradataPhotoProtocol?) {
          thumbOption.resizeMode = .fast
        
        if photoProtocol != nil {
            
            if photoProtocol?.tradataPosition == TradataPosition.bottom{
                 ascending = photoProtocol?.tradataPhotoSort == TradataPhotoSort.inverted ? true : false
            }else{
                 ascending = photoProtocol?.tradataPhotoSort == TradataPhotoSort.inverted ? false : true
            }
            
            if (photoProtocol?.tradataMediaType.contains(TradataMediaType.image))!{
                self.isContainImage = true
            }else{
                self.isContainImage = false
            }
            if (photoProtocol?.tradataMediaType.contains(TradataMediaType.video))!{
                self.isContainVideo = true
            }else{
                 self.isContainVideo = false
            }
            
        }
    }
    
   
    func ansyFetchResults(result:@escaping(_ dataSource:[TDFetchResult])-> Void) -> Void {
        
        DispatchQueue.global().async {
            self.managerResult(collection: self.smart)
            self.managerResult(collection: self.userCustom)
            
         
            DispatchQueue.main.async(execute: {
                result(self.result)
            
            })
            
        }
    }
    
    //MARK:系统智能相册
    private var smart:PHFetchResult<AnyObject>!{
        
        return PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: PHFetchOptions()) as! PHFetchResult<AnyObject>
    }
    
    //MARK:用户自定义相册
    private var userCustom:PHFetchResult<AnyObject>!{
        
        return PHCollection.fetchTopLevelUserCollections(with: nil) as! PHFetchResult<AnyObject>
    }
    
    private func managerResult(collection:PHFetchResult<AnyObject>) ->Void{
        
        collection.enumerateObjects { (object, index, stop) in
            
            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                        ascending: self.ascending)]
            
            if self.isContainImage == true && self.isContainVideo == false{
                 options.predicate =  NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            }
            
            if self.isContainVideo == true && self.isContainImage == false{
                    options.predicate =  NSPredicate(format: "mediaType = %d", PHAssetMediaType.audio.rawValue)
                
            }
            
  
        
            guard object is PHAssetCollection else {return}
            let   assetObject = object  as!  PHAssetCollection
            
            let  assetResuable = PHAsset.fetchAssets(in: assetObject, options: options)
            
            if   assetResuable.count > 0 &&  assetObject.localizedTitle != "最近删除" {
                
                let result = TDFetchResult(title: assetObject.localizedTitle!, result: assetResuable)
                
              
                self.result.append(result)
            }
        }
        
    }
    
    
    //MARK:获取缩略图
    public  func libraryThumbnail(index:Int,assetsFetch:PHFetchResult<PHAsset>,thumbSize:CGSize,result:@escaping(_ image:UIImage,_ asset:PHAsset)->()) -> Void {
        
        let retainScale = UIScreen.main.scale
        let size =  CGSize(width: thumbSize.width * retainScale, height: thumbSize.height * retainScale)
        let asset = assetsFetch[index]
        
        self.imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: thumbOption) { (image, info) in
            
            
            result(image!,asset)
            
        }
        
        
    }
    
    
}











