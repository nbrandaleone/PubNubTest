//
//  ViewController.swift
//  PubNubTest
//
//  Created by Nick Brandaleone on 4/19/15.
//  Copyright (c) 2015 Nick Brandaleone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var chatView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.messageField.delegate = self
        self.chatView.text = ""
        
        // Get the notification center to use
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        // Get the operation queue to run the notification handler on
        let mainQueue = NSOperationQueue.mainQueue()
        
        // Create custom notification type
        let MyNotificationType = "inboundMessage"
    
        // Register for the notification ...
        notificationCenter.addObserverForName(MyNotificationType,object: nil,
            queue: mainQueue, usingBlock:{
                [unowned self] note in
                    self.updateChat(note)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChat(notification: NSNotification){
        
        // perhaps have name variable. Do not display text from myself?
        if let message = notification.object as? String{
            let displayMessage = "Message: \(message)\n"
            self.chatView.text = self.chatView.text + displayMessage
            // scroll text view to proper location...
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // MARK: - TextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let myChannel: PNChannel = PNChannel.channelWithName("a") as! PNChannel
        
        PubNub.sendMessage(textField.text, toChannel: myChannel)
        textField.text = ""
        
        return true
    }
}

