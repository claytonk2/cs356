//
//  ProfileScreenViewController.swift
//  Startup_App
//
//  Created by Clayton Kingsbury on 7/18/18.
//  Copyright © 2018 Clayton kingsbury. All rights reserved.
//

import UIKit

class ProfileScreenViewController: UITableViewController {
    @IBAction func ToSettings(_ sender: Any) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usersName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.borderColor = UIColor.black.cgColor
        self.profilePicture.layer.borderWidth = 3;
        usersName.text = userModel.user.firstName + " " + userModel.user.lastName

}
}

