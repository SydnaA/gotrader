//
//  FirstViewController.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-09-29.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, UITabBarControllerDelegate, UITableViewDelegate, UITableViewDataSource, LGChatControllerDelegate, CLLocationManagerDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var gotoPostView: UIButton!
    @IBOutlet var postsTable: UITableView!
    @IBOutlet weak var postButton: UIButton!
    
    var postPokemonName: [String] = []
    var postPokemonCP: [String] = []
    var postPokemonLocation: [String] = []
    var loginView : UIView?
    var curloc: [AnyObject]!
    
    var postArr : NSMutableArray = []
    
    var userID: Int = 3
    var userLat: Double = 0
    var userLng: Double = 0
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrievePost(userID)
        
        self.tabBarController!.delegate=self
        self.postsTable.delegate=self
        
        postButton.contentMode = .ScaleAspectFit
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(FirstViewController.updateRetrievePost), userInfo: nil, repeats: true)
        
    }
    
    func updateRetrievePost() {
        retrievePost(userID)
    }
    
    @IBAction func SignOutGoogle(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        let signInVC = self.storyboard!.instantiateViewControllerWithIdentifier("SignInVC") as! SignInViewController
        self.presentViewController(signInVC, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        curloc = locations
        let location:CLLocation = locations[locations.count-1] as CLLocation
        
        userLat = location.coordinate.latitude
        userLng = location.coordinate.longitude
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell") as! CustomTableViewCell
        //cell.backgroundColor = UIColor.purpleColor()
        
        dispatch_async(dispatch_get_main_queue()) {
            // code here
            cell.pokemon_image.image = UIImage(named: "test-screenshot.jpg")
            
            let post = self.postArr.objectAtIndex(indexPath.row) as! Post
            
            cell.pokemon_name.text = post.pokemon_name
            cell.pokemon_cp.text = "CP \(post.cp)"
            cell.trainer_name.text = post.first_name
            if (self.curloc != nil) {
                let tempLoc:CLLocation = CLLocation(latitude: post.lat, longitude: post.lng)
                self.calculateDistanceTo(tempLoc)
                cell.pokemon_location.text = "dist: \(self.calculateDistanceTo(tempLoc)) km"
            } else {
                cell.pokemon_location.text = "dist: N/A km"
            }
            
        }
        
        
        
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
    
    @IBAction func PostPressed(sender: UIButton) {
        let createPostController = self.storyboard!.instantiateViewControllerWithIdentifier("createNewPost") as! CreatePostController
        createPostController.lat = userLat
        createPostController.lng = userLng
        createPostController.userID = userID
        self.presentViewController(createPostController, animated: true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
    
    
    func userLogin(email: NSString)-> Int {
        var userID:NSString = "0"
        let request = NSMutableURLRequest(URL: NSURL(string: "urlString")!)
        request.HTTPMethod = "POST"
        let postString = "email=\(email)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            userID = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
        }
        task.resume()
        return Int(userID as String)!
    }
    
    func retrievePost(userID: Int)-> NSString {
        var postList:NSString = "[]"
        let request = NSMutableURLRequest(URL: NSURL(string: "http://go-trader.mybluemix.net/api/v1/post/get_posts")!)
        let json = [ "location":
            [
                "lat": 1,
                "lng": 1
            ],
            "range": 5000,
            "limit": 10,
            "page": 0,
            "sortType": "time"
        ]
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            request.HTTPMethod = "POST"
            request.setValue("\(userID)", forHTTPHeaderField: "user_id")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
        } catch {
            
        }
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            if data != nil {
                let json = JSON(data: data!)
                self.postArr.removeAllObjects()
                for (key, subJson) in json["response"] {
                self.postArr.addObject(Post(lat: subJson["lng"].double!, lng: subJson["lat"].double!, post_id: subJson["post_id"].int!, dist: subJson["dist"].double!, go_id: subJson["go_id"].int!, cp: subJson["cp"].int!, screenshot: subJson["screenshot"].string!, first_name: subJson["first_name"].string!))
                
                }
                self.postsTable.reloadData()
            }
        }
        task.resume()
        return postList
    }
    
    
    func retrieveUserPost(userID: Int64)-> NSString {
        var postList:NSString = "[]"
        let request = NSMutableURLRequest(URL: NSURL(string: "http://go-trader.mybluemix.net/api/v1/post/get_user_posts")!)
        request.setValue("3", forHTTPHeaderField: "user_id")
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            postList = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
        }
        task.resume()
        return postList
    }
    
    func calculateDistanceTo(loc: CLLocation) -> Double {
        var distance: CLLocationDistance = curloc[0].distanceFromLocation(loc)
        distance/=1000.0
        distance=Double(round(10*distance)/10)
        return distance
    }
    


    
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if (tabBarController.selectedIndex == 1) {
            let svc:SecondViewController! = viewController as? SecondViewController
            //svc.delegate=self
            print("Set")
            svc.passUserID(userID)
        }
        if (tabBarController.selectedIndex == 2) {
            let svc:ThirdViewController! = viewController as? ThirdViewController
            //svc.delegate=self
            print("Set")
            svc.passUserID(userID)
        }

    }
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
//    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        myActivityIndicator.stopAnimating()
//    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}

