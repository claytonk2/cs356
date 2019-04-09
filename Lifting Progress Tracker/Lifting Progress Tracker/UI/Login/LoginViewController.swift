//
//  LoginViewController.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 3/21/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import UIKit
// should replace this with the firebase stuff
class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    // Check username and password for useable characters/ spaces
    @IBAction func LoginPressed(_ sender: UIButton) {
        var username:String = usernameTxt.text! // I added the ! to both of these so I dont know if that will work
        var password:String = passwordTxt.text!
        var success: Bool = false
        if ( username.isEqual("") || password.isEqual("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Login Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        } else {
            //if successful
            userModel.user.setUsername(username: username)
            userModel.user.setPassword(password: password)
            
            // this should be taken out when the beta test is over
            
            //            if (username.isEqual("admin") && password.isEqual("admin")){
            //                userModel.user.setFirstName(name: "Test")
            //                userModel.user.setLastName(name: "Account")
            //                self.performSegue(withIdentifier: "log_in", sender: self)
            //                return // this should be taken out when beta testing
            //                // return and do transition
            //            }
            
            
            
            var returnInfo: Any
            
//            do {
//                var info =  [infoToSend]()
//                info.append(infoToSend.init(label: "password", info: password))
//                info.append(infoToSend.init(label: "username", info: username))
//                returnInfo = try contactServer.instance.Contact(info: info, context: "login")
//                if let stringCheck = returnInfo as? String  {
//                    if (returnInfo as! String).isEqual("Error"){
//                        success = false
//                    }
//
//                }
//                else if ((returnInfo as! NSDictionary).value(forKey: "error")  != nil) {
//                    success = false//display error
//                }
//                else {
//                    success = true
//                    userFactory().create(jsonData: returnInfo)
//                }
//            }
//            catch{
//                var alertView:UIAlertView = UIAlertView()
//                alertView.title = "Login Failed!"
//                alertView.message = "Server Error"
//                alertView.delegate = self
//                alertView.addButton(withTitle: "OK")
//                alertView.show()
//            }
            NSLog("Success: %ld", success);
            
            if(success)
            {
                NSLog("Login SUCCESS");
                
                //                        var alertView:UIAlertView = UIAlertView()
                //                        alertView.title = "Login Success!"
                //                        alertView.message = "Now Work on Server"
                //                        alertView.delegate = self
                //                        alertView.addButton(withTitle: "OK")
                //                        alertView.show()
                LoginCheck.instance.logIn()
                self.performSegue(withIdentifier: "log_in", sender: self)
            } else {
                //                        var error_msg:NSString
                //
                //                        if (returnInfo as! NSDictionary)["error_message"] as? NSString != nil {
                //                            error_msg = (returnInfo as! NSDictionary)["error_message"] as! NSString
                //                        } else {
                //                            error_msg = "Unknown Error"
                //                        }
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
//                if let temp: String = returnInfo as? String{
//                    if ( (returnInfo as! String).isEqual("Error")){
//                        alertView.message = "Server Issue"
//                    }
//                }
//                else{
//                    alertView.message = ((returnInfo as! NSDictionary).value(forKey: "error") as! String)
//                }
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
                
            }
            
            
        }
    }
    @IBAction func RegisterPagePressed(_ sender: UIButton) {
        // let appDomain = Bundle.main.bundleIdentifier
        //UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        
        self.performSegue(withIdentifier: "goto_register", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
