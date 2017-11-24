//
//  ViewController.swift
//  GoodShow
//
//  Created by Tim Harris on 11/18/17.
//  Copyright © 2017 Tim Harris. All rights reserved.
//

import UIKit
import Photos
import CoreLocation

var goodshowEvents:PHFetchResult<PHAsset> = PHFetchResult()

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var goodshowCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodshowCollectionView.delegate = self
        goodshowCollectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
         loadPhotoLibrary()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        //print("\(goodshowEvents.count)")
        return 1
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("\(goodshowEvents.count)")
        return goodshowEvents.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let goodshowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "goodshowCell", for: indexPath) as! goodshowEventCell
        
        
        
        // Set Cell Data
        goodshowCell.image.image = goodshowCell.fetchImage(asset: goodshowEvents.object(at: indexPath.row))
        goodshowCell.mediaCount.text = goodshowCell.fetchLocationString(aLocation: goodshowEvents.object(at: indexPath.row).location)
        //print("\(aLocation: goodshowEvents.object(at: indexPath.row).location)")
        goodshowCell.dateUpdated.text = goodshowCell.formatDateString(aDate: goodshowEvents.object(at: indexPath.row).creationDate!)
        return goodshowCell
    }
    
    func loadPhotoLibrary() -> Void {
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
                //print("YES")
                goodshowEvents = PHAsset.fetchAssets(with: .image, options: PHFetchOptions())
                //print("\(goodshowEvents.count) found!")
                OperationQueue.main.addOperation {
                    self.goodshowCollectionView.reloadData()
                }
                
                //return photos
            }
        })
    }
    
    
}


class goodshowEventCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateUpdated: UILabel!
    @IBOutlet weak var mediaCount: UILabel!
    
    var imageText:String = ""
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        self.dateUpdated.textColor = UIColor.gray
        self.mediaCount.textColor = UIColor.gray
        
    }
    
    func formatDateString(aDate: Date) -> String {
        let goodshowCellDateFormatter = DateFormatter()
        goodshowCellDateFormatter.dateFormat = "MMM dd"
        return goodshowCellDateFormatter.string(from: aDate)
    }
    
    func fetchImage(asset:PHAsset) -> UIImage {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        var image = UIImage()
        imageManager.requestImage(for: asset, targetSize: CGSize(width: self.image.bounds.width, height: self.image.bounds.height), contentMode: .aspectFit, options: requestOptions, resultHandler: { (result, info) -> Void in
            image = result!
        })
        
        let locationString = fetchLocationString(aLocation: asset.location)
        let updatedImage = addLocationToImage(image: image, locationString: locationString, imageView: self.image)
        
        return updatedImage
        
    }
    
    
    func fetchLocationString(aLocation:CLLocation?) -> String {
        var locationString = "test"
        let geoCoder = CLGeocoder()
        
        if let goodLocation = aLocation {
            geoCoder.reverseGeocodeLocation(goodLocation, completionHandler: {(response, error) in
                if let addr = response?.first {
                    //print(addr.locality!)
                    locationString = addr.locality!
                    
                }
            })
        }
        
        return locationString
    }
    
    func addLocationToImage(image:UIImage, locationString: String, imageView: UIImageView) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        let textFontAttributes = [NSAttributedStringKey.font: textFont, NSAttributedStringKey.foregroundColor: textColor,] as [NSAttributedStringKey : Any]
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let rect = CGRect(x: 10, y: imageView.bounds.height , width: image.size.width, height: image.size.height)
        locationString.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImageWithText!
    }
    
}
