//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Kevin Bradwick on 06/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let memes: [Meme] = MemeManager.sharedInstance().memes
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    /*!
        Show the meme editor so that they can start over
    */
    @IBAction func launchMemeEditorViewController(sender: AnyObject) {
        
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as EditorViewController
        presentViewController(controller, animated: true, completion: nil)
    }
}
