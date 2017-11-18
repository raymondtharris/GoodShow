//
//  Event.swift
//  GoodShow
//
//  Created by Tim Harris on 11/18/17.
//  Copyright © 2017 Tim Harris. All rights reserved.
//

import Foundation
import Photos

class goodshowEvent{
    var name: String = ""
}


func loadPhotoLibrary() -> Void {
    PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus) in
        switch status {
        case .notDetermined:
            print("no determined")
        case .restricted:
            print("maybe a little")
        case .denied:
            print("nope")
        case .authorized:
            print("YES")
            let options = PHFetchOptions()
            let photos = PHAsset.fetchAssets(with: .image, options: options)
            print("\(photos.count) found!")
        }
    })
}
