//
//  postViewController.swift
//  Hackergram
//
//  Created by Marc Gugliuzza on 10/9/14.
//  Copyright (c) 2014 77th Street Labs. All rights reserved.
//

import UIKit

class postViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    var activityIndicator = UIActivityIndicatorView()
    var photoSelected:Bool = false


    
    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBAction func logout(sender: UIBarButtonItem) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
    
    @IBAction func chooseImage(sender: UIButton) {

        
        var image = UIImagePickerController()
        image.delegate = self
        
        if TARGET_IPHONE_SIMULATOR != 1 {
            println("has a camera available")
            image.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else {
            println("NO camera available")
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
        }
        
        image.allowsEditing = false
        
        self.photoSelected = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var shareText: UITextField!
    
    @IBAction func postImage(sender: UIButton) {
        self.showProgressBar()
        
        var error = ""
        
        if self.photoSelected == false {
            error = "Please select an image to post"
        } else if self.shareText.text == "" {
            error = "Please enter a message"
        }
        
        if error != "" {
            self.resumeFromProgressBar()
            displayAlert(title: "Cannot post image", message: error)
        } else {
            var post = PFObject(className: "Post")
            post["Title"] = self.shareText.text
            post["username"] = PFUser.currentUser().username
            
            post.saveInBackgroundWithBlock({ (success: Bool!, error: NSError!) -> Void in
                println("starting the save...")
                if (success == false) {
                    self.resumeFromProgressBar()
                    self.displayAlert(title: "Cannot post image", message: "Please try again later")
                }
                else {
                    
                    let image = self.imageToPost.image!
                    
                    let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.1, 0.1))
                    let hasAlpha = false
                    let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
                    
                    UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
                    image.drawInRect(CGRect(origin: CGPointZero, size: size))
                    
                    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                    
                    
                    let imageData = UIImagePNGRepresentation(scaledImage)
                    
                    
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    post["imageFile"] = imageFile
                    
                    post.saveInBackgroundWithBlock({ (success: Bool!, error: NSError!) -> Void in
                        if success == false {
                            self.resumeFromProgressBar()
                            
                            self.displayAlert(title: "Cannot post image", message: "Please try again later")
                            
                        }
                        else {
                            println("SAVEDD!!")
                            self.resumeFromProgressBar()

                            self.displayAlert(title: "YAYER", message: "Posted that image!")
                            
                            
                            self.photoSelected = false
                            self.imageToPost.image = UIImage(named: "monkey.png")
                            self.shareText.text = ""
                            
                        }
                    })
                    
                }
                
            })
            
        }
        println("end of the function")
        
    }
    
    func displayAlert(title: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            println("Test")
            //self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showProgressBar(){
        self.activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func resumeFromProgressBar(){
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        self.imageToPost.image = image
    }
    
    override func viewDidLoad() {
        println("device: \(TARGET_IPHONE_SIMULATOR)")
        self.shareText.delegate = self
        super.viewDidLoad()
        Parse.setApplicationId("ZJHaDPsK5OS63UJfEv7GGtfKEu2K2wYjFQLMRU3L", clientKey: "fgrift4Ic04xVqQIkvfa6LqQfg7UFCEXjqdmvbbO")
        self.photoSelected = false
        self.imageToPost.image = UIImage(named: "monkey.png")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
