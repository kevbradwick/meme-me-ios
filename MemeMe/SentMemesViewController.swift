//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Kevin Bradwick on 06/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        memes = MemeManager.sharedInstance().memes
    }
    
    // MARK: TableView data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableCell") as MemeTableViewCell
        
        let meme = memes[indexPath.row]
        cell.previewImage.image = meme.memedImage
        cell.memeTitle.text = "\(meme.topText), \(meme.bottomText)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    // MARK: Tableview delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // TODO: - display generated meme
    }
    
}
