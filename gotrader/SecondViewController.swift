//
//  SecondViewController.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-09-29.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LGChatControllerDelegate {
    
    var chatLastUpdateTime: [String] = ["12:12pm","1:00pm","3:00pm"]
    var chatTitle: [String] = ["Chat Title 1", "Chat Title 2", "Chat Title 3"]
    var chatSubtitle: [String] = ["Chat subtitle 1", "Chat subtitle 3", "Chat subtitle 3"]

    @IBOutlet weak var ChatTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChatTableView.dataSource=self
        self.ChatTableView.delegate=self
        //self.ChatTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatTitle.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = self.chatLastUpdateTime[indexPath.row] + " - " + self.chatTitle[indexPath.row]
        cell.detailTextLabel?.text = self.chatSubtitle[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected row: \(indexPath.row)")
        self.launchChatController()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func launchChatController() {
        let chatController = LGChatController()
        chatController.opponentImage = UIImage(named: "User")
        chatController.title = "Simple Chat"
        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        chatController.messages = [helloWorld]
        chatController.delegate = self
        presentViewController(chatController, animated: true, completion: nil)
    }
    
    // MARK: LGChatControllerDelegate
    
    func chatController(chatController: LGChatController, didAddNewMessage message: LGChatMessage) {
        print("Did Add Message: \(message.content)")
    }
    
    func shouldChatController(chatController: LGChatController, addMessage message: LGChatMessage) -> Bool {
        /*
         Use this space to prevent sending a message, or to alter a message.  For example, you might want to hold a message until its successfully uploaded to a server.
         */
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

