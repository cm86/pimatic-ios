//
//  TestViewController.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 01.07.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class HomeViewController: UITableViewController, ENSideMenuDelegate {
    
    var homeItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .None
        self.tableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "homeCell")

        
        homeItems = ["Test1", "Test2", "Test3"]
        
        self.sideMenuController()?.sideMenu?.delegate = self
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
        return homeItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = homeItems[indexPath.row]
        return cell
    }
}
