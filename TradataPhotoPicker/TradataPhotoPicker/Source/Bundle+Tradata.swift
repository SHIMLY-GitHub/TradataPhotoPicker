//
//  Bundle+Tradata.swift
//  TradataPhotoPicker
//
//  Created by 董家祎 on 2018/9/16.
//  Copyright © 2018年 djy. All rights reserved.
//

import Foundation
import UIKit
extension Bundle {
    
    
    
    static var TradataBundle: Bundle{
        return Bundle.init(path:Bundle.init(for: TradataPhotoPickerController.self).path(forResource: "TradataPhotoBundle", ofType: "bundle")!)!
    }
    
    static var tradata_goback: UIImage{
        
        return (UIImage.init(contentsOfFile: self.TradataBundle.path(forResource: "tradat_goback@2x", ofType: "png")!)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))!
        
    }
}
