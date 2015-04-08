//
//  MemeManager.swift
//  MemeMe
//
//  Created by Kevin Bradwick on 06/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

//
// This class stores memes in memory and can be accessed from 
// anywhere in the app.
//
class MemeManager {
    
    var memes = [Meme]()
    
    // only this class can create instances of itself
    private init() {}
    
    /*!
        The shared instance of the MemeManager for this application
    */
    class func sharedInstance() -> MemeManager {
        struct Static {
            static let instance = MemeManager()
        }
        
        return Static.instance
    }
    
    /*!
        Adds a new Meme object
    */
    func add(meme: Meme) {
        self.memes.append(meme)
    }
    
    /*!
        Add a new Meme by providing its property values
    */
    func add(topText t1: String, bottomText t2: String, originalImage i1: UIImage, memedImage i2: UIImage) {
        self.memes.append(Meme(topText: t1, bottomText: t2, withImage: i1, memedImage: i2))
    }
}