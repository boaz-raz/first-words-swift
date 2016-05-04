//
//  PhotoGallaryViewController.swift
//  My First Words
//
//  Created by Boaz Raz on 5/4/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit
import Photos

let reuseID = "PhotoCell"

// App specific album
let albumName = "My First Words"

class PhotoGallaryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var albumFound: Bool = false
    // The folder for the app
    var assetCollection: PHAssetCollection!
    
    // All the photos in the array
    var photoAsset: PHFetchResult!
    
    @IBAction func btnCamera(sender: AnyObject) {
        print("Camera")
    }
    
    
    @IBAction func btnAlbum(sender: AnyObject) {
        print("Album")
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchOptions = PHFetchOptions()
        // locking to the allbum name
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        
        // Check it there is app specific photos folder if not create one (ios 8)
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        // Test if the album is ex
        if(collection.firstObject != nil) {
            // found the album
            self.albumFound = true
            self.assetCollection = collection.firstObject as! PHAssetCollection
        
        } else {
            // create the folder
            NSLog("\nFolder \"%@\" dose not exist\nCreating folder now..", albumName)
            //Sigenton for phone framwrok
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                // we want to create an ablum
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                
                },
                completionHandler: {(success:Bool, error:NSError?) in
                    NSLog("Creating of folder -> %@", (success ? "Success" : "Error!"))
                    self.albumFound = (success ? true:false)
            })
        }
        
    } // END override
    
    override func viewWillAppear(animated: Bool) {
        
        // keep the navigation on the screen
        self.navigationController?.hidesBarsOnTap = false
        
        // get the phots from the collection // this is only contians the url of the images
        self.photoAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        
        
        // Handle no photos in the assetsCollecitn
        
        
        self.collectionView.reloadData()
    }
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // tells us the numbers of cells we need
        return self.photoAsset.count;
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as UICollectionViewCell
        
        return cell
        
    }
    
    
    
} // END CLASS

