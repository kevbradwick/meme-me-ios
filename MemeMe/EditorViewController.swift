//
//  EditorViewController.swift
//  MemeMe
//
//  Created by Kevin Bradwick on 05/04/2015.
//  Copyright (c) 2015 KodeFoundry. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: MemeTextField!
    @IBOutlet weak var bottomText: MemeTextField!
    @IBOutlet var activityButton: UIBarButtonItem!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    var memeManager = MemeManager.sharedInstance()
    
    let notificationCenter = NSNotificationCenter.defaultCenter()
        
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
        notificationCenter.addObserver(self, selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification, object: nil)
        
        // reset the view when keyboard dissappears
        notificationCenter.addObserver(self, selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification, object: nil)
        
        // hide the status bar everytime the view is about to appear
        UIApplication.sharedApplication().statusBarHidden = true
        
        // disable the cancel button if there are no memes
        if memeManager.memes.count == 0 {
            cancelButton.enabled = false
        }
    }
    
    /*!
        Clean up notification center observers.
    */
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeRegisteredNotificationObservers()
    }
    
    /*!
        Remove keyboard notification observers.
    */
    private func removeRegisteredNotificationObservers() {
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /*!
        This will launch the activity view controller with the current Meme image. It will also store the memed image
        using the shared MemeManager.
    */
    @IBAction func launchActivityController() {
        
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        // completion handler will add the meme to the global collection
        controller.completionWithItemsHandler = { (activityType: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) in
            if completed == true {
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
    @IBAction func showMemeHistory(sender: AnyObject) {
        self.performSegueWithIdentifier("showMemeHistory", sender: nil)
    }
    
    /*!
        Generates a new memed image from the current view.
    */
    func generateMemedImage() -> UIImage {
        
        hideToolbarAndNavigationBar(true)
        
        // render the current view to an image object
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        hideToolbarAndNavigationBar(false)
        
        return memedImage as UIImage
    }
    
    private func hideToolbarAndNavigationBar(hide: Bool) {
        toolbar.hidden = hide
        navigationBar.hidden = hide
    }
    
    // MARK: - Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomText.isFirstResponder() {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            self.view.frame.origin.y -= keyboardSize.CGRectValue().height
        }
    }
    
    /*!
        Pull the view back down once the keyboard dissapears.
    */
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    // MARK: - Image picker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        activityButton.enabled = true
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Interface Builder Actions
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        launchImagePicker(forSourceType: .PhotoLibrary)
    }
    
    /*!
        Launch the camera and use it to capture an image for the meme
    */
    @IBAction func pickAnImageUsingCamera(sender: AnyObject) {
        launchImagePicker(forSourceType: .Camera)
    }
    
    /*!
        Launch the Image Picker controller with different source types.
    */
    private func launchImagePicker(forSourceType sourceType: UIImagePickerControllerSourceType) {
        
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = self
        presentViewController(controller, animated: true, completion: nil)
    }
}

