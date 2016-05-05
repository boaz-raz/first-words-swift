//
//  PhotoThumbCollectionViewCell.swift
//  First Words Final Project
//
//  Created by Boaz Raz on 5/4/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class PhotoThumbCollectionViewCell: UICollectionViewCell {
  
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    // get the image
    func setThumbnailImage(thumbnailImage: UIImage) {
        self.imgView.image = thumbnailImage
    }
    
}
