//
//  ViewController.swift
//  MemeMe
//
//  Created by Kevin Bradwick on 05/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: MemeTextField!
    @IBOutlet weak var bottomText: MemeTextField!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // default text used to check when deciding to clear field
        topText.defaultText = "TOP"
        bottomText.defaultText = "BOTTOM"
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        // add notification for when keyboard is about to show
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    // MARK: - Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        println("Keyboard is about to be shown")
    }

    // MARK: - Image picker
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Interface Builder Actions
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        
        let controller = UIImagePickerController()
        controller.sourceType = .PhotoLibrary
        controller.delegate = self
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageUsingCamera(sender: AnyObject) {
        
        let controller = UIImagePickerController()
        controller.sourceType = .Camera
        controller.delegate = self

        presentViewController(controller, animated: true, completion: nil)
    }
}

