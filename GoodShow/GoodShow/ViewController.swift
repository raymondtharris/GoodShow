//
//  ViewController.swift
//  GoodShow
//
//  Created by Tim Harris on 11/18/17.
//  Copyright © 2017 Tim Harris. All rights reserved.
//

import UIKit
import Photos

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
        goodshowCell.mediaCount.text = "4"
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
                print("YES")
                goodshowEvents = PHAsset.fetchAssets(with: .image, options: PHFetchOptions())
                print("\(goodshowEvents.count) found!")
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true

        
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
        return image
        
    }
}
