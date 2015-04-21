//
//  AppDelegate.swift
//  PubNubTest
//
//  Created by Nick Brandaleone on 4/19/15.
//  Copyright (c) 2015 Nick Brandaleone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // set delegate
        PubNub.setDelegate(self)
        
        // set the pubnub keys to demo
        PubNub.setConfiguration(PNConfiguration.defaultConfiguration())
        
        // connect to PubNub
        PubNub.connect()
        
        // subscribe to a channel
        let myChannel: PNChannel = PNChannel.channelWithName("a") as! PNChannel
        PubNub.subscribeOn([myChannel])
        PubNub.enablePresenceObservationFor([myChannel])
        
        // publish on the channel
        // PubNub.sendMessage("Hello from PubNub ios!", toChannel: myChannel)
        
        return true
    }

    // MARK:- PubNub Delegate method
    func pubnubClient(client: PubNub, didReceiveMessage aMessage: PNMessage) -> Void{
        
        // posting a message using Notification Center
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let MyNotificationType = "inboundMessage"
        notificationCenter.postNotificationName(MyNotificationType, object: aMessage.message)
    }
    
    deinit{
        // unsubscribe from the channel
        let myChannel: PNChannel = PNChannel.channelWithName("a") as! PNChannel
        PubNub.unsubscribeFrom([myChannel])
        
        // disconnect from PubNub
        PubNub.disconnect()
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

