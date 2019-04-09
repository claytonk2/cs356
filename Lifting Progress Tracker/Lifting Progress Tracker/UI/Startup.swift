//
//  Startup.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 3/21/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class StartViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var LoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        LoginButton.addTarget(self,
//                           action: #selector(firebaseLogin),
//                           for: .touchUpInside)
        
//        Authorization.instance.RequestPermission() // set this up for permissions
        
        
        if LoginCheck.instance.checkLogin() == true {
            LoginCheck.instance.loadInfo()
//            FetchNote().fetch()
//            FetchReminder().fetch()
//            FetchWorkouts().fetch()
            
        }
        else{
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
        }
        self.performSegue(withIdentifier: "pre_log", sender: self)
    }
//    @objc func firebaseLogin(){
//        Auth.auth().signIn(withCustomToken: customToken ?? "") { (user, error) in
//            userModel.setUserId(userId: user as! String)
//            self.performSegue(withIdentifier: "pre_log", sender: self)
//        }
//    }
    
    
    
    
    
    
}
