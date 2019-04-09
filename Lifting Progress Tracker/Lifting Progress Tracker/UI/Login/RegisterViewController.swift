//
//  RegisterViewController.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 3/21/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    // TODO add in /  use all of the other information in if statements
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var confPasswordTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var confEmailTxt: UITextField!
    
    
    @IBAction func AlreadyRegister(_ sender: UIButton) {
        // let appDomain = Bundle.main.bundleIdentifier
        //   UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        
        self.performSegue(withIdentifier: "goto_login", sender: self)
        
    }
    @IBAction func RegisterPressed(_ sender: UIButton) {
        let username:String = usernameTxt.text!
        let password:String = passwordTxt.text!
        let firstName:String = firstNameTxt.text!
        let lastName:String = lastNameTxt.text!
        let confirm_password:String = confPasswordTxt.text!
        
        if ( username.isEqual("") || password.isEqual("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Regester Failed!"
            alertView.message = "Please enter Information"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        } else if ( !password.isEqual(confirm_password) ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Passwords doesn't Match"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        } else {
            //if successful
            userModel.user.setUsername(username: username as String)
            userModel.user.setPassword(password: password as String)
            userModel.user.setFirstName(name: firstName as String)
            userModel.user.setLastName(name: lastName as String)
            //            var alertView:UIAlertView = UIAlertView()
            //            alertView.title = "Sign Up Success!"
            //            alertView.message = "Now Figure out the Server"
            //            alertView.delegate = self
            //            alertView.addButton(withTitle: "OK")
            //            alertView.show()
            do{
//                var info =  [infoToSend]()
//                info.append(infoToSend.init(label: "password", info: password))
//                info.append(infoToSend.init(label: "username", info: username))
//                info.append(infoToSend.init(label: "firstname", info: firstName))
//                info.append(infoToSend.init(label: "lastname", info: lastName))
//                var returnInfo = try contactServer.instance.Contact(info: info, context: "register")
//                //userFactory.create(userFactory)
//                //check result before to see if server got it.
//                if ( (returnInfo as! NSDictionary).value(forKey: "result") as! String).isEqual("success") {
//                    LoggedInCheck.instance.logIn()
//                    self.performSegue(withIdentifier: "reg_in", sender: self)
//                }
//                else{
//                    var alertView:UIAlertView = UIAlertView()
//                    alertView.title = "Sign Up Failed!"
//                    alertView.message = ((returnInfo as! NSDictionary).value(forKey: "result") as! String)
//                    alertView.delegate = self
//                    alertView.addButton(withTitle: "OK")
//                    alertView.show()
//                }
            }
            catch{
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Regester Failed!"
                alertView.message = "Server Error"
                alertView.delegate = self
                alertView.addButton(withTitle: "OK")
                alertView.show()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func GoToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "goto_login", sender: self)
    }
    
}
extension RegisterViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

