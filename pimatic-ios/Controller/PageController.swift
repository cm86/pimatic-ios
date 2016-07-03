//
//  PageController.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 02.07.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

import SwiftyJSON

class PageController {
    
    var pages = [PageModel]()
    
    private func getPage(jsonData: JSON) -> PageModel {
        
        let page = PageModel()
        
        page.id = jsonData["id"].string!
        page.name = jsonData["name"].string!
        
        for i in 0..<jsonData["devices"].count {
            page.devices.append(jsonData["devices"][i]["deviceId"].string!)
        }
        
        return page
    }
    
    func setPages(view: SideViewController) {
        ConnectionController.sharedSession.socket.on("pages") { data, ack in
            
            // ensure that pages are empty at the beginning of new pages
            
            self.pages = [PageModel]()
            
            let json = JSON(data)
            
            //iterate over all pages
            for i in 0..<json[0].count {
                self.pages.append(self.getPage(json[0][i]))
            }
            
            view.menuItems = self.returnPageNames()
        }
    }
    
    func returnPageNames() -> [String] {
        
        var items = [String]()
        
        for i in 0..<pages.count {
            items.append(self.pages[i].name)
        }

        return items
    }
    
    func getID(name: String) -> String {
        for page in pages {
            if(name == page.name) {
                return page.id
            }
        }
        
        return ""
    }
    
    func getDeviceNames(id: String) -> [String] {
        for page in pages {
            if(id == page.id) {
                return page.devices
            }
        }
        
        return [""]
    }
    
    static let sharedSession = PageController()
}
