//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Kevin Bradwick on 08/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var memeImageView: UIImageView!
    
    var meme: Meme?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let meme = self.meme {
            memeImageView.image = meme.memedImage
        }
    }
}
