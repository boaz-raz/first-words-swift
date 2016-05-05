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
    
    var index: Int = 0;
    
    
    
    @IBAction func btnCancel(sender: AnyObject) {
        print("Cancel")
    }
    
    @IBAction func btnShare(sender: AnyObject) {
        print("Share")
    }
    

    
    @IBAction func btnDelete(sender: AnyObject) {
    }
    
    //imageView
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {

        self.navigationController?.hidesBarsOnTap = true
        self.displayPhoto()
        
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
    }
}
