//
//  SecondViewController.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-09-29.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LGChatControllerDelegate {
    
    var chatLastUpdateTime: [String] = ["time"]
    var chatTitle: [String] = ["title"]
    var chatSubtitle: [String] = ["subtitle"]
    var userID:Int?
    
    var chatArr : NSMutableArray = []

    @IBOutlet weak var ChatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChatTableView.dataSource=self
        self.ChatTableView.delegate=self
        
        //self.ChatTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ChatTableViewCell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func passUserID(userID: Int)
    {
        self.userID=1
        retrievePost(1)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell", forIndexPath: indexPath) as UITableViewCell
        dispatch_async(dispatch_get_main_queue()) {
            let post = self.chatArr.objectAtIndex(indexPath.row) as! chatHack
            
            cell.textLabel?.text = "\(post.pokemon_name)"
            cell.detailTextLabel?.text = ""
        }
        
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
        chatController.title = "Lets Talk"
//        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        chatController.messages = []
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
    
    func retrievePost(userID: Int)-> NSString {
        var postList:NSString = "[]"
        let request = NSMutableURLRequest(URL: NSURL(string: "http://go-trader.mybluemix.net/api/v1/chat/get_user_chat_list")!)
        request.HTTPMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("1", forHTTPHeaderField: "user_id")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            let json = JSON(data: data!)
            self.chatArr.removeAllObjects()
//            print(json.rawString())
            for (key, subJson) in json["response"] {
//                print(json)
                self.chatArr.addObject(chatHack(chat_id: subJson["chat_id"].int!, go_id: subJson["go_id"].int!))
            }
            self.ChatTableView.reloadData()
        }
        task.resume()
        return postList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

