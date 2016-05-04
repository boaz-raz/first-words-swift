//
//  ViewPhotoController.swift
//  First Words Final Project
//
//  Created by Boaz Raz on 5/4/16.
//  Copyright © 2016 Boaz Raz. All rights reserved.
//

import UIKit

class ViewPhotoController: UIViewController {
    
    @IBAction func btnCancel(sender: AnyObject) {
        print("Cancel")
        //self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func btnShare(sender: AnyObject) {
        print("Share")
    }
    
    
    @IBAction func btnDelete(sender: AnyObject) {
        print("Delete")
    }
    
    
    @IBOutlet weak var imgFullSize: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
} // END CLASS
