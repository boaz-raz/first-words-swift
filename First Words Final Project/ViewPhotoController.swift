//
//  ViewPhotoController.swift
//  My First Words
//
//  Created by Boaz Raz on 5/4/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit
import Photos

class ViewPhotoController: UIViewController {
    
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    var index: Int = 0
    
    
    @IBAction func btnVancel(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    

    @IBAction func btnShare(sender: AnyObject) {
        print("Share")
    }
    @IBAction func btnDelete(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Delete Image", message: "Are you sure you want to delete this image?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .Default,
            handler: {(alertAction)in
                PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    //Delete Photo
                    if let request = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection){
                        request.removeAssets([self.photosAsset[self.index]])
                    }
                    },
                    completionHandler: {(success, error)in
                        NSLog("\nDeleted Image -> %@", (success ? "Success":"Error!"))
                        alert.dismissViewControllerAnimated(true, completion: nil)
                        if(success){
                            // Move to the main thread to execute
                            dispatch_async(dispatch_get_main_queue(), {
                                self.photosAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection, options: nil)
                                if(self.photosAsset.count == 0){
                                    print("No Images Left!!")
                                    self.navigationController?.popToRootViewControllerAnimated(true)
                                }else{
                                    if(self.index >= self.photosAsset.count){
                                        self.index = self.photosAsset.count - 1
                                    }
                                    self.displayPhoto()
                                }
                            })
                        }else{
                            print("Error: \(error)")
                        }
                })
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: {(alertAction)in
            //Do not delete photo
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
   
   
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
        
        self.displayPhoto()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    
    func displayPhoto(){
        // Set targetSize of image to iPhone screen size
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let targetSize = CGSizeMake(screenSize.width, screenSize.height)
        
        let imageManager = PHImageManager.defaultManager()
        if let asset = self.photosAsset[self.index] as? PHAsset{
            imageManager.requestImageForAsset(asset, targetSize: targetSize, contentMode: .AspectFit, options: nil, resultHandler: {
                (result, info)->Void in
                self.imgView.image = result
            })
        }
        print("This is a test")
    }
    
    
    
}
