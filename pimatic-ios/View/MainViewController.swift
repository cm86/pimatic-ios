//
//  MainViewController.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 30.06.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//



import UIKit
import ENSwiftSideMenu

class MainViewController: ENSideMenuNavigationController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.hidesBackButton = true
        
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: SideViewController(),menuPosition:.Left)
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 180.0 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        //sideMenu?.allowPanGesture = false
        // make navigation bar showing over side menu
        view.bringSubviewToFront(navigationBar)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}