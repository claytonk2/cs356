//
//  LoggedInCheck.swift
//  Startup_App
//
//  Created by Clayton kingsbury on 3/20/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
// eventually we need to return a id from the server when logged in and store it in the server too so instead of using the username to get information we use the id

class LoginCheck{
    static let instance = LoginCheck()
    func logIn(){
        let dict = ["fName" : userModel.user.firstName, "lName" : userModel.user.lastName, "username" : userModel.user.username]
        // load the health kit from here
        UserDefaults.standard.set(true, forKey: "logged_in")
        UserDefaults.standard.set(dict, forKey: "dict")
        UserDefaults.standard.synchronize()
        
    }
    func signOut(){
        // clear?
        UserDefaults.standard.set(false, forKey: "logged_in")
        UserDefaults.standard.synchronize()
    }
    private init() {
    }
    func checkLogin() -> Bool{
        return UserDefaults.standard.bool(forKey: "logged_in")
    }
    func loadInfo(){
        do {
            let dict = UserDefaults.standard.object(forKey: "dict") as? [String: String] ?? [String: String]()
            try  userModel.user.setFirstName(name: dict["fName"]!)
            try  userModel.user.setLastName(name: dict["lName"]!)
            try  userModel.user.setUsername(username: dict["username"]!)
        }
        catch{
            
        }
    }
}
