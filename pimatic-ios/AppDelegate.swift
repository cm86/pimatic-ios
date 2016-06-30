//
//  AppDelegate.swift
//  pimatic-ios
//
//  Created by Moritz Weichert on 27.06.16.
//  Copyright © 2016 Moritz Weichert. All rights reserved.
//

import UIKit
import SocketIOClientSwift
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginController = LoginController()
    var socket: SocketIOClient!
    var json: [String: AnyObject]!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        /*socket = SocketIOClient(socketURL: NSURL(string: "http://unifi:80")!, options: [ ])
        
        socket.connect()
        
        socket.on("connect") { ack in
            self.socket.emit("call", ["id" : "callAction", "action" : "removeGroup", "params" : [ "groupId" : "test"]] )
        }
        
        socket.on("callResult") { data, ack in
            
            let json = JSON(data)
            debugPrint(json[0]["id"].string)
        }
        
        
         socket.on("rules") {data, ack in
         print(data)
         }*/
        
        
        if let loginViewController = window?.rootViewController as? LoginViewController {
            loginViewController.loginController = loginController
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

