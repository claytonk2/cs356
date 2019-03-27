//
//  ProfileViewController.swift
//  Startup_App
//
//  Created by Clayton kingsbury on 7/13/18.
//  Copyright © 2018 Clayton kingsbury. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    let list = ["Health Records", "Reminders"]
    var myIndex = 0
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usersName: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var InputOpen: UIButton!
    @IBOutlet weak var DataInput: UIButton!
    @IBOutlet weak var FeedbackInput: UIButton!
    @IBOutlet weak var NoteInput: UIButton!
    @IBOutlet weak var NoteLabel: UILabel!
    @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var FeedbackLabel: UILabel!
    @IBOutlet weak var ShadowCover: UIButton!
    @IBOutlet weak var ProfileTableView: UITableView!
    
    @IBOutlet weak var SettingsTapped: UIBarButtonItem!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            //myIndex = indexPath.row
            //Commenting this out to see if the issue is coming from the fact that myIndex = indexPath.row maybe shouldn't be there
            self.performSegue(withIdentifier: "RemindersSegue", sender: self)
        } else {
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "Health Records Segue", sender: self)
            } else {
                
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowProfile()
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        self.profilePicture.layer.borderColor = UIColor.lightGray.cgColor
        self.profilePicture.layer.borderWidth = 3
        
        usersName.text = userModel.user.firstName + " " + userModel.user.lastName
        // Do any additional setup after loading the view.
        
//        InputOpen.createFloatingActionButton()
//        DataInput.createFloatingActionButton()
//        FeedbackInput.createFloatingActionButton()
//        NoteInput.createFloatingActionButton()
        
        closeMenu()
    
    }
    
    
    
    //Import Profile Image
    @IBAction func importProfileImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        self.present(image, animated: true){
            // After it is complete
        }
        
        
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            profilePicture.image = image
//            StoreImage().store(image: image)
//        } else {
//            //Error Message
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
    
    
    //FAB Menu Stuff
//    @IBAction func BackgroundTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//    @IBAction func FeedbackTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//    @IBAction func DataTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//    @IBAction func NotesTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//
    
//    @IBAction func menuTapped(_ sender: FloatingActionButton) {
//        UIView.animate(withDuration: 0.2, animations: {
//            if self.menuView.transform == .identity {
//                self.closeMenu()
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.ShadowCover.isHidden = true
//                })
//            } else {
//                self.menuView.transform = .identity
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.ShadowCover.isHidden = false
//                })
//            }
//        })
//        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
//            if self.menuView.transform == .identity {
//                self.DataInput.transform = .identity
//                self.DataLabel.transform = .identity
//                self.NoteInput.transform = .identity
//                self.NoteLabel.transform = .identity
//                self.FeedbackInput.transform = .identity
//                self.FeedbackLabel.transform = .identity
//            }
//        })
//
//    }
    
    func closeMenu() {
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        NoteInput.transform = CGAffineTransform(translationX: 0,y: 15)
        NoteLabel.transform = CGAffineTransform(translationX: 0,y: 15)
        DataInput.transform = CGAffineTransform(translationX: 11, y: 11)
        DataLabel.transform = CGAffineTransform(translationX: 11, y: 11)
        FeedbackInput.transform = CGAffineTransform(translationX: 15, y: 0)
        FeedbackLabel.transform = CGAffineTransform(translationX: 15, y: 0)
        ShadowCover.isHidden = true
    }
    
    func shadowProfile() {
        self.profilePicture.layer.shadowRadius = 25
        self.profilePicture.layer.shadowOpacity = 0.25
        self.profilePicture.layer.shadowOffset = CGSize(width: 25, height: 25)
        self.profilePicture.layer.shadowColor = UIColor.black.cgColor
        self.profilePicture.clipsToBounds = true
    }
    
    //Button Tapped and Menu closes
    func InputButtonTapped(){
        UIView.animate(withDuration: 0.2, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
                UIView.animate(withDuration: 0.2, animations: {
                    self.ShadowCover.isHidden = true
                })
            } else {
                
            }
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.menuView.transform == .identity {
                self.DataInput.transform = .identity
                self.DataLabel.transform = .identity
                self.NoteInput.transform = .identity
                self.NoteLabel.transform = .identity
                self.FeedbackInput.transform = .identity
                self.FeedbackLabel.transform = .identity
            }
        })
        UIView.animate(withDuration: 0.3, animations: {
            if self.InputOpen.transform == .identity {
                self.InputOpen.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
            } else {
                self.InputOpen.transform = .identity
            }
        })
    }
    
}
