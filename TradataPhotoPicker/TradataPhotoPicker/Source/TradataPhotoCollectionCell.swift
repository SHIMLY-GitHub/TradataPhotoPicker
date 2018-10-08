//
//  TradataPhotoCollectionCell.swift
//  TradataPhotoPicker
//
//  Created by 董家祎 on 2018/9/16.
//  Copyright © 2018年 djy. All rights reserved.
//

import UIKit

protocol TradataPhotoCollectionProtocol{
    
}



class TradataPhotoCollectionCell: UICollectionViewCell {
    
    var imageView:UIImageView = UIImageView()
    
    var selectButton:UIButton = UIButton()
    
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        selectButton.frame = CGRect(x: self.bounds.size.width-10, y: self.bounds.size.height-10, width: 30, height: 30)
        
        
        
        self.addSubview(selectButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
