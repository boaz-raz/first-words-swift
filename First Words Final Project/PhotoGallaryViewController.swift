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

class PhotoGallaryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var albumFound: Bool = false
    // The folder for the app
    var assetCollection: PHAssetCollection!
    
    // All the photos in the array
    var photoAsset: PHFetchResult!
    
    
    
    @IBAction func btnCamera(sender: AnyObject) {
        print("Camera")
        // check if the camera is avilable
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)){
            // laod camera
            
            let picker : UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
            
        } else {
            //no camera available
            let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)

        }
    }
    
    @IBAction func btnAlbum(sender: AnyObject) {
        print("btnAlbum was clicked")
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
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
        self.photoAsset? = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
        
        
        // Handle no photos in the assetsCollecitn
        
        
        self.collectionView?.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier! as String == "viewLargePhoto") {
            let controller:ViewPhotoController = segue.destinationViewController as! ViewPhotoController
            
            // get the index of the photo
            let indexPhath: NSIndexPath = self.collectionView.indexPathForCell(sender as! UICollectionViewCell)!
        
            controller.index = indexPhath.item
            
            // pass info to ViewPhoroConreoller
            controller.photoAsset = self.photoAsset
            controller.assetCollection = self.assetCollection
            
        }
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        
        var count: Int = 0
        
        if(self.photoAsset != nil){
            count = self.photoAsset.count
        }
        // tells us the numbers of cells we need
        return count;
        
       
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: PhotoThumbCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as! PhotoThumbCollectionViewCell
        
        //
        let asset: PHAsset = self.photoAsset[indexPath.item] as! PHAsset
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil)  {(result:UIImage?, info:[NSObject : AnyObject]?) -> Void in
            cell.setThumbnailImage(result!)
        
        }
        
        return cell
        
    }
    
    // UICollectionViewDelegateFlowLayout methods
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 4
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }

    
    
    // Handeling the image
    
    //TODO
    //UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let image: UIImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            //Implement if allowing user to edit the selected image
          
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), {
                PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                    let assetPlaceholder = createAssetRequest.placeholderForCreatedAsset
                    if let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection, assets: self.photoAsset) {
                        albumChangeRequest.addAssets([assetPlaceholder!])
                    }
                    }, completionHandler: {(success, error)in
                        dispatch_async(dispatch_get_main_queue(), {
                            NSLog("Adding Image to Library -> %@", (success ? "Sucess":"Error!"))
                            picker.dismissViewControllerAnimated(true, completion: nil)
                        })
                })
                
            })
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
} // END CLASS

