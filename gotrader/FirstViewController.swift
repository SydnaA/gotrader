//
//  FirstViewController.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-09-29.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LGChatControllerDelegate {

    @IBOutlet var postsTable: UITableView!
    var postPokemonName: [String] = ["Blastoise", "Blastoise", "Blastoise"]
    var postPokemonCP: [String] = ["122", "233", "434"]
    var postPokemonLocation: [String] = ["Location 1", "Location 2", "Location 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postsTable.delegate=self
        //self.postsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postPokemonName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell") as! CustomTableViewCell
        //cell.backgroundColor = UIColor.purpleColor()
        
        cell.pokemon_name.text = self.postPokemonName[indexPath.row]
        cell.pokemon_cp.text = "CP " + self.postPokemonCP[indexPath.row]
        cell.pokemon_location.text = self.postPokemonLocation[indexPath.row]
        cell.pokemon_image.image = UIImage(named: "test-screenshot.jpg")

//    
//        if let nameLabel = cell.contentView.viewWithTag(10) as? UILabel {
//            nameLabel.text = self.items[indexPath.row]
//        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected row: \(indexPath.row)")
        self.launchChatController()
//        let modalStyle = UIModalTransitionStyle.CrossDissolve
//        let svc : UINavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("NAV") as! UINavigationController
//        svc.modalTransitionStyle = modalStyle
//        presentViewController(svc, animated: true, completion: nil)
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func launchChatController() {
        let chatController = LGChatController()
        chatController.opponentImage = UIImage(named: "User")
        chatController.title = "Simple Chat"
        let helloWorld = LGChatMessage(content: "Hello World!", sentBy: .User)
        let helloWorldOp = LGChatMessage(content: "Hello World!", sentBy: .Opponent)
        //chatController.messages = [helloWorld, helloWorldOp]
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

