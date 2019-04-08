//
//  NoteInputViewController.swift
//  Havenly
//
//  Created by Benjamin Walter on 7/27/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import UIKit

class NoteInputViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let list = [String](arrayLiteral: "Food","Medication","Activity","Device","Personal","Misc.")
    
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var SubmitFeedback: UIButton!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var FeedbackTextBox: UITextView!
    @IBOutlet weak var TagInputBox: UITextView!
    @IBOutlet weak var CategoryTextBox: UITextField!
    @IBOutlet weak var CategoryIcon: UIImageView!
    
    @IBAction func SubmitFeedback(_ sender: UIButton) {
        let MainLineNotes: String = FeedbackTextBox.text!
        let TagLine: String = TagInputBox.text!
        
        if (MainLineNotes.isEqual("") || MainLineNotes.isEqual("Enter Notes Here")){
            
        } else {
//            TotalNotesModel.notes.setNotesTitle(MainLineNotes: MainLineNotes as String)
//            TotalNotesModel.notes.setTagTitle(TagLine: TagLine as String)
//
//            do{
//                var info = [infoToSend]()
//                info.append(infoToSend.init(label: "MainLineNotes", info: MainLineNotes))
//                info.append(infoToSend.init(label: "TagLine", info: TagLine))
//            }
//            dismiss(animated: true, completion: nil)
//        }
            let date: NSDate = DatePicker!.date as NSDate
            let note: String = FeedbackTextBox.text!
            let tags: String = TagInputBox.text! // tags are set up weirldy //todo fix
            let noteOb: Note = Note(date: date, text: note, tags: tags)
            userModel.user.addNote(note: noteOb)
//            if let error: String = try ((dic as! NSDictionary).value(forKey: "error") as? String){
//                var alertView:UIAlertView = UIAlertView()
//                alertView.title = "Error While Saving Note!"
//                alertView.message = "Please try again or contact us with your issue"
//                alertView.delegate = self
//                alertView.addButton(withTitle: "OK")
//                alertView.show()
//            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            dismiss(animated: true)
        }

    }
    
    @IBAction func TouchOutside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let CategoryPicker = UIPickerView()
        
        CategoryTextBox.inputView = CategoryPicker
        
        CategoryPicker.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        self.CategoryIcon.layer.cornerRadius = CategoryIcon.frame.size.width / 2
        self.CategoryIcon.layer.masksToBounds = true
        self.CategoryIcon.layer.borderWidth = 1
        self.CategoryIcon.layer.borderColor = UIColor.lightGray.cgColor
        
        self.RoundedView.layer.cornerRadius = 15
        self.RoundedView.layer.masksToBounds = true
        
        self.FeedbackTextBox.layer.borderColor = UIColor.lightGray.cgColor
        self.FeedbackTextBox.layer.borderWidth = 1
//        self.TagInputBox.layer.borderColor = UIColor.lightGray.cgColor
//        self.TagInputBox.layer.borderWidth = 1
        

        TagInputBox.delegate = self
        FeedbackTextBox.text = "Enter Notes Here"
        FeedbackTextBox.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  textView.text == "Enter Notes Here" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    //Put X cancel button in top right corner
    @IBAction func closeFeedback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            textView.textColor = UIColor.lightGray
        }
        return true
    }
    //Category Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if (row == 0){
            let image = UIImage(named: "Apple Icon")
            self.CategoryIcon.image = image
        }
        else if (row == 1){
            let image = UIImage(named: "Pill Icon")
            self.CategoryIcon.image = image
            //Medication
        }
        else if (row == 2){
            let image = UIImage(named: "Activity Icon")
            self.CategoryIcon.image = image
            //Activity
        }
        else if (row == 3){
            let image = UIImage(named: "Glucometer Icon")
            self.CategoryIcon.image = image
            //Device
        }
        else if (row == 4){
            let image = UIImage(named: "Profile Empty")
            self.CategoryIcon.image = image
            //Personal
        }
        else if (row == 5){
            let image = UIImage(named: "Pin Icon")
            self.CategoryIcon.image = image
            //Misc.
        }
    }
}

extension NoteInputViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NoteInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
