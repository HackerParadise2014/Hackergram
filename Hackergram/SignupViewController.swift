//
//  SignupViewController.swift
//  Hackergram
//
//  Created by Marc Gugliuzza on 9/30/14.
//  Copyright (c) 2014 77th Street Labs. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Parse.setApplicationId("ZJHaDPsK5OS63UJfEv7GGtfKEu2K2wYjFQLMRU3L", clientKey: "fgrift4Ic04xVqQIkvfa6LqQfg7UFCEXjqdmvbbO")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil {
            println("User logged in, segue'ing to user view")
            self.performSegueWithIdentifier("toUserListSegue", sender: self)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func loginSegmentedControlPressed(sender: UISegmentedControl) {
        
        println(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            // signup view
            self.signUpView.hidden = false
            self.loginView.hidden = true
        } else if sender.selectedSegmentIndex == 1 {
            // login view
            self.signUpView.hidden = true
            self.loginView.hidden = false
        }
        
        
    }
    func createUser() {
        var user = PFUser()
        user.username = self.username.text
        user.password = self.password.text
        user.email = self.email.text
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                println("create account success")
                
                // setup hack to follow yourself
                var following = PFObject(className: "followers")
                following["following"] = PFUser.currentUser().username
                following["follower"] = PFUser.currentUser().username
                following.saveInBackground()
                
                self.username.text = ""
                self.password.text = ""
                self.email.text = ""
                self.performSegueWithIdentifier("toUserListSegue", sender: self)
                println("doing toUserListSegue ")
            } else {
                println("Failure: \(error)")
                
                self.showAlertWithMessage("Failure", message: "Something went wrong.")
                //                let errorString = error.userInfo["error"] as NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
    }
    
    @IBAction func signup(sender: UIButton) {
        self.createUser()
    }
    
    @IBAction func login(sender: UIButton) {
        
        PFUser.logInWithUsernameInBackground(self.loginUsername.text, password:self.loginPassword.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("login success")
                self.performSegueWithIdentifier("toUserListSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
                println("login failure")
                self.showAlertWithMessage("Failure", message: "Invalid credentials.")
            }
        }
    }
    
    //helper functions
    func showAlertWithMessage(header:String, message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
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
