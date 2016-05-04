//
//  ViewPhotoController.swift
//  My First Words
//
//  Created by Boaz Raz on 5/4/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class ViewPhotoController: UIViewController {
    
    
    
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
}
