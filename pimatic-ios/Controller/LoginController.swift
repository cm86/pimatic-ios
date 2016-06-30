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
                address = NSURL(fileURLWithPath: "https://" + login.hostname + ":" + login.port)
            } else {
                address = NSURL(fileURLWithPath: "http://" + login.hostname + ":" + login.port)
            }
            
            socket = SocketIOClient(socketURL: address, options: [ .Log(true), .Reconnects(true), .ReconnectWait(5), .SelfSigned(true), .ConnectParams(["username" : login.username, "password" : login.password]), .ForceNew(true)])
            
            socket.connect(timeoutAfter: 20, withTimeoutHandler: timeoutHandler)
            
            socket.on("connect") { ack in
                print ("Hallo")
                self.circle.hidden = true
            }
        }
        
        
    }
    
    func timeoutHandler() -> Void {
        socket.disconnect()
        socket.removeAllHandlers()
        circle.hidden = true
        debugPrint("Timeout")
    }
    
    func getActivityCircle(circle : UIActivityIndicatorView) {
        self.circle = circle
    }
    
}
