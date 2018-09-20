//
//  TradataPhotoPickerProtocol.swift
//  TradataPhotoPicker
//
//  Created by 董家祎 on 2018/9/15.
//  Copyright © 2018年 djy. All rights reserved.
//

import Foundation
import UIKit

enum TradataStatusBarStyle:Int {
    
    case white
    case black
}

enum TradataPhotoSort:Int {
    case positive //正序
    case inverted //倒序
    
}


enum TradataPosition {
    //从底部开始向上滚动
    case bottom
    //从顶部开始向下滚动
    case top
}

 struct TradataMediaType: OptionSet {
    
    let rawValue: Int
    
    static let image = TradataMediaType(rawValue: 1)
    
    static let video = TradataMediaType(rawValue: 2)
   
}

protocol TradataPhotoProtocol {
    
   
    var tradataPhotoSort:TradataPhotoSort{get}
    
    
 
    var tradataPosition:TradataPosition{get}
    
    
   
    var tradataMediaType:TradataMediaType {get}
    
    
}

extension TradataPhotoProtocol{
     /// 图片排序方式 默认按 时间倒序排列
    var tradataPhotoSort:TradataPhotoSort{
    
        return TradataPhotoSort.inverted
    }
    
    /// 图片起始位置  默认从底部开始向上滚动
    
    var tradataPosition:TradataPosition{
    
        return TradataPosition.bottom
    }
    
     /// 可以选择的图片类型
     var tradataMediaType:TradataMediaType {
        
         return [TradataMediaType.image,TradataMediaType.video]
    }
    
}

protocol TradataNavProtocol {
  
    var tradataBarTintColor:UIColor{get}
    
    var tradataStatusBarStyle:TradataStatusBarStyle{get}
    
    var tardataTitleThemeColor:UIColor {get}
    
    
}

extension TradataNavProtocol{
    
    
     /// 导航栏背景颜色 默认是黑色
     var tradataBarTintColor:UIColor{
        
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    /// 状态栏颜色 默认白色
    var tradataStatusBarStyle:TradataStatusBarStyle{
        return TradataStatusBarStyle.white
    }
    
    /// 导航栏的主题颜色 默认白色
    var tardataTitleThemeColor:UIColor{
        
        return UIColor.white;
    }
    
    
    
}
