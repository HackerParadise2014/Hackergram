//
//  ViewController.swift
//  Hackergram
//
//  Created by Marc Gugliuzza on 9/25/14.
//  Copyright (c) 2014 77th Street Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var pickedImage: UIImageView!
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBAction func pickImageButtonPress(sender: UIButton) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func restore(sender: UIButton) {
        self.activityIndicator.stopAnimating()
        //        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    @IBAction func pause(sender: UIButton) {
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
        //        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        
        
    }
    
    @IBAction func createAlert(sender: UIButton) {
        var alert = UIAlertController(title: "Hi", message: "Thing", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            println("Test")
            //self.dismissViewControllerAnimated(true, completion: nil)

        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        self.pickedImage.image = image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Parse.setApplicationId("ZJHaDPsK5OS63UJfEv7GGtfKEu2K2wYjFQLMRU3L", clientKey: "fgrift4Ic04xVqQIkvfa6LqQfg7UFCEXjqdmvbbO")
        
        
        /*
        var score = PFObject(className: "score")
        score.setObject("Rob", forKey: "name")
        score.setObject(95, forKey: "number")
        score.saveInBackgroundWithBlock {
        (success: Bool!, error: NSError!) -> Void in
        
        
        if success == true {
        println("Score created with ID: \(score.objectId)")
        } else {
        println(error)
        }
        
        }
        
        
        var query = PFQuery(className: "score")
        query.getObjectInBackgroundWithId("aXtkzCAzr7", block: { (score: PFObject!, error: NSError!) -> Void in
        if (error == nil) {
        //                println(score.objectForKey("name") as NSString)
        score["name"] = "Robert"
        score["number"] = 137
        score.saveInBackground()
        
        } else {
        println(error)
        }
        })
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

