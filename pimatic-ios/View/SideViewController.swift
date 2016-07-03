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
    var segueItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)

        // Customize apperance of table view
        //tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.backgroundColor = UIColor.cyanColor()
        tableView.separatorStyle = .None
        //tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        PageController.sharedSession.setPages(self)
        
        menuItems = PageController.sharedSession.returnPageNames()
        self.tableView.reloadData()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        menuItems = PageController.sharedSession.returnPageNames()
        tableView.reloadData()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cellName = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        let cellID = PageController.sharedSession.getID(cellName!)
        
        segueItems = PageController.sharedSession.getDeviceNames(cellID)
        
        self.performSegueWithIdentifier("EditHome", sender: self)
 
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "EditHome") {
            
            let navController = segue.destinationViewController as? MainViewController
            
            let homeView = navController?.topViewController as? HomeViewController
            
            homeView!.homeItems = segueItems
        }
        
    }
}