//
//  ConnectionController.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 30.06.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

import SocketIOClientSwift

class ConnectionController {
    
    var socket : SocketIOClient!
    
    func connect(url : NSURL, user : String, password: String) {
        
        socket = SocketIOClient(socketURL: url, options: [ .Log(true), .Reconnects(true), .ReconnectWait(5), .SelfSigned(true), .ConnectParams(["username" : user, "password" : password]), .ForceNew(true)])
        
        socket.connect(timeoutAfter: 20, withTimeoutHandler: timeoutHandler)
        
        
    }
    
    func timeoutHandler() -> Void {
        socket.disconnect()
        socket.removeAllHandlers()
        debugPrint("Timeout")
    }
    
    static let sharedSession = ConnectionController()
}