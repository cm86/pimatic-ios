//
//  LoginController.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 29.06.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

import SocketIOClientSwift

class LoginController {
    
    var circle : UIActivityIndicatorView!
    
    var login = LoginModel(host: "", port: "", user: "", password: "", ssl: false)
    var socket : SocketIOClient!
    
    var validData = false
    
    
    func getLoginData(host: String, port: String, user: String, password: String, ssl: Bool) {
        
        guard !host.isEmpty &&
              !port.isEmpty &&
              !user.isEmpty &&
              !password.isEmpty else {
                validData = false
                return
        }
        
        validData = true
        
        debugPrint("Hostname: " + host)
        debugPrint("Port:" + port)
        debugPrint("Username: " + user)
        debugPrint("Password: " + password)
        debugPrint("SSL: " + ssl.description)
        login = LoginModel(host: host, port: port, user: user, password: password, ssl: ssl)
    }
    
    func handleErrorMessage(label: UILabel) {
        if(validData == true) {
            label.hidden = true
        } else {
            label.hidden = false
        }
    }
    
    func connect() {
        
        if (validData == true) {
            
            circle.hidden = false
            
            let address : NSURL
            
            if ( login.ssl == true ) {
                address = NSURL(string: "https://" + login.hostname + ":" + login.port)!
            } else {
                address = NSURL(string: "http://" + login.hostname + ":" + login.port)!
            }
            
            ConnectionController.sharedSession.connect(address, user: login.username, password: login.password)
            
            ConnectionController.sharedSession.socket.on("connect") { ack in
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController
                let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
                
                appDelegate?.window?.rootViewController = viewController
            }
        }
        
        
    }
    
    
    func getActivityCircle(circle : UIActivityIndicatorView) {
        self.circle = circle
    }
    
}
