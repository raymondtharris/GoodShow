//
//  Media.swift
//  GoodShow
//
//  Created by Tim Harris on 12/2/17.
//  Copyright © 2017 Tim Harris. All rights reserved.
//

import Foundation
import Photos

class goodShowMedia {
    var name:String = ""
    var type: PHAssetMediaType = PHAssetMediaType.image
    var asset: PHAsset?
    var location: CLLocation?
    
    var views:Int = 0
    var likes:Int = 0
    var caption:String = ""
    var comments:Array<String> = []
}
