//
//  LoginModel.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 29.06.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//


class LoginModel {
    var hostname : String
    var port : String
    var username : String
    var password : String
    var ssl : Bool
    
    init(host: String, port: String, user: String, password: String, ssl: Bool) {
        self.hostname = host
        self.port = port
        self.username = user
        self.password = password
        self.ssl = ssl
    }
}