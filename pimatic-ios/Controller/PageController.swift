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
    
    init() {
        
        
    }
    
    
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
            
            let json = JSON(data)
            
            //iterate over all pages
            for i in 0..<json[0].count {
                self.pages.append(self.getPage(json[0][i]))
            }
            
            view.menuItems = self.returnPageNames()
            view.tableView.reloadData()
        }
    }
    
    func returnPageNames() -> [String] {
        
        var items = [String]()
        
        for i in 0..<pages.count {
            items.append(self.pages[i].name)
        }

        return items
    }
    
    static let sharedSession = PageController()
}
