//
//  SignInViewController.swift
//  gotrader
//
//  Created by Sydna Agnehs on 2016-11-27.
//  Copyright © 2016 Sydna Agnehs. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshInterface()
        (UIApplication.sharedApplication().delegate as! AppDelegate).signInCallBack = refreshInterface
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    func refreshInterface() {
        print("refresh")
//        if let currentUser = GIDSignIn.sharedInstance().currentUser {
//            print("Welcome, \(currentUser.profile.name)")
//            let firstViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainScreen") as! UITabBarController
//            self.presentViewController(firstViewController, animated: true, completion: nil)
//        }
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()) {
            let firstViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainScreen") as! UITabBarController
            self.presentViewController(firstViewController, animated: true, completion: nil)
        }
        
    }

}
