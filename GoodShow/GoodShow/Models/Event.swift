//
//  Event.swift
//  GoodShow
//
//  Created by Tim Harris on 11/18/17.
//  Copyright © 2017 Tim Harris. All rights reserved.
//

import Foundation
import Photos

//var photoArray:PHFetchResult<PHAsset> = PHFetchResult()

class goodshowEvent{
    var name: String = ""
    var media:Array<goodShowMedia> = []
}

/*
mutating func loadPhotoLibrary(photoLib:PHFetchResult<PHAsset>) -> Void {
    PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus) in
        switch status {
        case .notDetermined:
            print("no determined")
            //return nil
        case .restricted:
            print("maybe a little")
            //return nil
        case .denied:
            print("nope")
            //return nil
        case .authorized:
            print("YES")
            photoLib = PHAsset.fetchAssets(with: .image, options: PHFetchOptions())
            print("\(photoLib.count) found!")
            //photoArray = photos
            //return photos
        }
    })
    //return photoArray
}
*/
