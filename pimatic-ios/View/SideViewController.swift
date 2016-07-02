//
//  SideViewController.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 01.07.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

import UIKit
import SwiftyJSON

class SideViewController: UITableViewController {
    
    var menuItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.backgroundColor = UIColor.cyanColor()
        tableView.separatorStyle = .None
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        PageController.sharedSession.setPages(self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        return menuItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = menuItems[indexPath.row]
        return cell
    }
}