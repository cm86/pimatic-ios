//
//  LoginViewController.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 28.06.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var hostname: UITextField!
    @IBOutlet weak var port: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var ssl: UISwitch!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var loginCircle: UIActivityIndicatorView!
    
    var loginController : LoginController?
    
    var keyup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginController?.getActivityCircle(loginCircle)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if (keyup == false) {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.view.frame.origin.y -= keyboardSize.height
            }
            keyup = true
        }
        
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if (keyup == true) {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.view.frame.origin.y += keyboardSize.height
                keyup = false
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.nextField != nil) {
            textField.nextField?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @IBAction func performLogin(sender: AnyObject) {
        
        loginController?.getLoginData(hostname.text!, port: port.text!, user: username.text!, password: password.text!, ssl: ssl.on)
        
        loginController?.handleErrorMessage(self.errorMsg)
        
        loginController?.connect(self.storyboard,  navController: self.navigationController!)
        
        /*
        if let mainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController {
            self.navigationController?.presentViewController(mainViewController, animated: true, completion: nil)
        }
        */
        
        
    }
}

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    @IBOutlet var nextField: UITextField? {
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}