//
//  ViewController.swift
//  TradataPhotoPicker
//
//  Created by 董家祎 on 2018/9/15.
//  Copyright © 2018年 djy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   
   
    @IBAction func buttonAction(_ sender: Any) {
        
        TradataPhotoPickerController.tradataPhotoPicker(controller: self)
        
        
    }
    

}




