//
//  PageModel.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 02.07.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

class PageModel {
    
    var name: String
    var id: String
    
    var devices: [String]
    
    init() {
        self.name = ""
        self.id = ""
        self.devices = [""]
    }
    
    init(name: String, id: String, devices: [String]) {
        self.name = name
        self.id = id
        self.devices = devices
    }
    
    
}
