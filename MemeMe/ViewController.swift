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
    @IBOutlet var activityButton: UIBarButtonItem!
    
    var memeManager = MemeManager.sharedInstance()
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // default text used to check when deciding to clear field
        topText.defaultText = "TOP"
        bottomText.defaultText = "BOTTOM"
        
        activityButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        // add notification for when keyboard is about to show
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification, object: nil)
        
        // hide the status bar everytime the view is about to appear
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    /*!
        This will launch the activity view controller with the current Meme image. It will also store the memed image
        using the shared MemeManager.
    */
    @IBAction func launchActivityController() {
        
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        // completion handler will add the meme to the global collection
        controller.completionHandler = { (activityType, completed: Bool) in
            if completed == true {
                println("Image added to meme manager")
                self.memeManager.add(topText: self.topText.text, bottomText: self.bottomText.text,
                    originalImage: self.imageView.image!, memedImage: memedImage)
                
                self.performSegueWithIdentifier("showMemeHistory", sender: memedImage)
            }
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    /*!
        Reset the controller to the same state as when the app first loads
    */
    @IBAction func resetMemeEditor(sender: AnyObject) {
        
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        imageView.image = nil
        activityButton.enabled = false
    }
    
    /*!
        Generates a new memed image from the current view.
    */
    func generateMemedImage() -> UIImage {
        
        // TODO: - Hide toolbar and nav bar
        
        // render the current view to an image object
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage as UIImage
    }
    
    // MARK: - Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomText.isFirstResponder() {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
            self.view.frame.origin.y -= keyboardSize.CGRectValue().height
        }
    }

    // MARK: - Image picker
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imageView.image = image
        activityButton.enabled = true
        picker.dismissViewControllerAnimated(true, completion: nil)
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

