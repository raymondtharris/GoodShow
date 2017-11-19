//
//  ViewController.swift
//  GoodShow
//
//  Created by Tim Harris on 11/18/17.
//  Copyright © 2017 Tim Harris. All rights reserved.
//

import UIKit
import Photos

class ViewController: UICollectionViewController {
    
    var goodshowEvents:PHFetchResult<PHAsset> = PHFetchResult()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        goodshowEvents = loadPhotoLibrary()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("\(goodshowEvents.count)")
        return goodshowEvents.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(goodshowEvents.count)")
        return goodshowEvents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let goodshowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "goodshowCell", for: indexPath) as! goodshowEventCell
        goodshowCell.backgroundColor = UIColor.black
        return goodshowCell
    }
}


class goodshowEventCell: UICollectionViewCell {
    
}
