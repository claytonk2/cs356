//
//  DataInputViewController.swift
//  Havenly
//
//  Created by Clayton Kingsbury on 7/27/18.
//  Copyright © 2019 Clayton Kingsbury. All rights reserved.
//

import UIKit

class DataInputViewController: UIViewController, UITextViewDelegate {

    
//    @IBOutlet weak var DataTypePicker: UIPickerView!
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var RepsInput: UITextField!
    @IBOutlet weak var SubmitFeedback: UIButton!
    @IBOutlet weak var SetsInput: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var WeightInput: UITextField!
    let service: WorkoutService = WorkoutService()
    //@IBOutlet weak var DatePicker: UIDatePicker!
    @IBAction func SubmitFeedback(_ sender: UIButton) {
        var dataType: String = ""
        var index = 0
        
        
        var name: String = NameInput.text!
        var reps: String = RepsInput.text!
        var date: Date = DatePicker.date
        var sets: String = RepsInput.text!
        var weight: String = WeightInput.text!
        var success: Bool = true
        do {
            try service.save(sets: sets, reps: reps, weight: weight, name: name, date: date)
        }
        catch {
            print( error)
        }
        var alertView:UIAlertView = UIAlertView()
        if !success{
            alertView.title = "Error While Saving Reading!"
            alertView.message = "Make sure you have allowed for healthkit access your health information!"
            alertView.delegate = self
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }
        
       // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        dismiss(animated: true)
    }
    
    var BloodPressureSelected = 1
    var MedicationSelected = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.RoundedView.layer.cornerRadius = 15
        self.RoundedView.layer.masksToBounds = true
        
        

        
        self.WeightInput.keyboardType = UIKeyboardType.numberPad
        self.RepsInput.keyboardType = UIKeyboardType.numberPad
        self.SetsInput.keyboardType = UIKeyboardType.numberPad
//        view.bringSubviewToFront(DataTypePicker)
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if  textView.text == "Enter Notes Here" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        else if textView.text == "Enter Any #Tags Here"{
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
    }
    
    @IBAction func closeFeedback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func TouchOutside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            textView.textColor = UIColor.lightGray
        }
        return true
    }
    
}


    


extension DataInputViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DataInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
