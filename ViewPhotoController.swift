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

    var photoAsset: PHFetchResult!
    
    var index: Int = 0;
    
    
    
    @IBAction func btnCancel(sender: AnyObject) {
        print("Cancel")
    }
    
    @IBAction func btnShare(sender: AnyObject) {
        print("Share")
    }
    

    
    @IBAction func btnDelete(sender: AnyObject) {
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {

        self.navigationController?.hidesBarsOnTap = true
        self.displayPhoto()
        
    }
    
    func displayPhoto(){
        let imageManager = PHImageManager.defaultManager()
        var ID = imageManager.requestImageForAsset(self.photoAsset[self.index] as! PHAsset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFit, options: nil) { (result:UIImage?, info:[NSObject : AnyObject]?) -> Void in
            self.imageView.image = result
            
        }
    }
}
