//
//  EventViewController.swift
//  GoodShow
//
//  Created by Tim Harris on 12/2/17.
//  Copyright © 2017 Tim Harris. All rights reserved.
//

import Foundation
import Photos

class GoodShowEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath )
        return newCell
    }
    
}
