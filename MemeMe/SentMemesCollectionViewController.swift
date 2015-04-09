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
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    /*!
        Launch the detail view and pass the selected meme as the sender
    */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showMeme", sender: memes[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! DetailViewController
        controller.meme = sender! as? Meme
    }
    
    /*!
        Show the meme editor so that they can start over
    */
    @IBAction func launchMemeEditorViewController(sender: AnyObject) {
        
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! EditorViewController
        presentViewController(controller, animated: true, completion: nil)
    }
}
