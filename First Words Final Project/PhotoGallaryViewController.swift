//
//  PhotoGallaryViewController.swift
//  First Words Final Project
//
//  Created by Boaz Raz on 5/3/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit
//import Photos

// Concttoin
let reuseID = "PhotoCell"

class PhotoGallaryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // Action
    
    @IBAction func btnCamera(sender: AnyObject) {
    }
    
    @IBAction func btnPhotoAlbum(sender: AnyObject) {
    }
    
    // Refrence to the collection view
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //UICollection 

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Loop
        return 1;
        
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as UICollectionViewCell
        
        // Modify the cell
        //cell.backgroundColor = UIColor.redColor()
        
        return cell
        
    }

    
} // END CLASS
