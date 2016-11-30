//
//  ThirdViewController.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-10-19.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, LGChatControllerDelegate {

 
    
    @IBOutlet weak var ChatTableView: UITableView!
    var chatArr : NSMutableArray = []
    var userID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChatTableView.dataSource=self
        self.ChatTableView.delegate=self
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(ThirdViewController.updateRetrievePost), userInfo: nil, repeats: true)
    }
    
    func updateRetrievePost() {
        retrieveUserPost(self.userID!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell", forIndexPath: indexPath) as UITableViewCell
        
        dispatch_async(dispatch_get_main_queue()) {
            let post = self.chatArr.objectAtIndex(indexPath.row) as! Post
            
            cell.textLabel?.text = "\(post.pokemon_name)"
            cell.detailTextLabel?.text = "CP \(post.cp)"
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
    
    
    func launchChatController() {
        let chatController = LGChatController()
        chatController.opponentImage = UIImage(named: "User")
        chatController.title = "Simple Chat"
        //        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        chatController.messages = []
        chatController.delegate = self
        presentViewController(chatController, animated: true, completion: nil)
    }
    
    
    func retrieveUserPost(userID: Int)-> NSString {
        var postList:NSString = "[]"
        let request = NSMutableURLRequest(URL: NSURL(string: "http://go-trader.mybluemix.net/api/v1/post/get_user_posts")!)
        request.setValue("3", forHTTPHeaderField: "user_id")
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            postList = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
            if data != nil {
                    let json = JSON(data: data!)
//                print(postList)
                self.chatArr.removeAllObjects()
                for (key, subJson) in json["response"] {
                    self.chatArr.addObject(Post(lat: 0, lng: 0, post_id: subJson["post_id"].int!, dist: 0, go_id: subJson["go_id"].int!, cp: subJson["cp"].int!, screenshot: subJson["screenshot"].string!, first_name: "Alex"))
                }
            self.ChatTableView.reloadData()
            }
        }
        
        task.resume()
        return postList
    }
    
    
    

    func passUserID(userID: Int)
    {
        self.userID=userID
        retrieveUserPost(userID)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
