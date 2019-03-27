//
//  DataInputViewController.swift
//  Havenly
//
//  Created by Benjamin Walter on 7/27/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import UIKit

class DataInputViewController: UIViewController, UITextViewDelegate {

    private let dataSource = ["Blood Glucose","Blood Pressure","Calories","Carbs","Heart Rate","Medication"]
    
    @IBOutlet weak var DataTypePicker: UIPickerView!
    @IBOutlet weak var MedicationInput: UITextField!
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var DataInputField: UITextField!
    @IBOutlet weak var SubmitFeedback: UIButton!
    @IBOutlet weak var FeedbackTextBox: UITextView!
    @IBOutlet weak var TagInputBox: UITextView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    //@IBOutlet weak var DatePicker: UIDatePicker!
    let service: HealthService = HealthService()
    var getter: GetAddedData = GetAddedData()
    @IBAction func SubmitFeedback(_ sender: UIButton) {
        var dataType: String = ""
        var index = 0
        let selectedRow = DataTypePicker.selectedRow(inComponent: index)
        if let s = DataTypePicker.delegate?.pickerView!(DataTypePicker, titleForRow: selectedRow, forComponent: index) {
            dataType += s
        }
        
        var data: String = DataInputField.text!
        var tags: String = TagInputBox.text!
        var feedback: String = FeedbackTextBox.text!
        var date: Date = DatePicker.date
        var dia: String = MedicationInput.text!
        var success: Bool = true
        do {
            success = try service.save(date: date, value: data, extraVal: dia, tags: tags, note: feedback, type: dataType)
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
        getter.get(type: dataType)
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
        
        self.FeedbackTextBox.layer.borderColor = UIColor.lightGray.cgColor
        self.FeedbackTextBox.layer.borderWidth = 1
        self.TagInputBox.layer.borderColor = UIColor.lightGray.cgColor
        self.TagInputBox.layer.borderWidth = 1
        
        TagInputBox.text = "Enter Any #Tags Here"
        TagInputBox.textColor = UIColor.lightGray
        
        FeedbackTextBox.text = "Enter Notes Here"
        FeedbackTextBox.textColor = UIColor.lightGray
        
        DataTypePicker.dataSource = self
        DataTypePicker.delegate = self
        TagInputBox.delegate = self
        DataInputField.isHidden = false
        self.DataInputField.placeholder = "mg/dL"
        self.DataInputField.keyboardType = UIKeyboardType.numberPad
        view.bringSubview(toFront: DataTypePicker)
        //self.BottomNumberInput.isHidden = true
        self.MedicationInput.isHidden = true
        
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

extension DataInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 14)
        
        // where data is an Array of String
        label.text = dataSource[row]
        
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if (row == 5){
            self.MedicationInput.isHidden = false
            self.MedicationInput.placeholder = "Name of Medication"
            self.MedicationInput.keyboardType = UIKeyboardType.alphabet
            self.DataInputField.placeholder = "Quantity"
        }
        else if (row == 0){
            self.MedicationInput.isHidden = true
            self.DataInputField.placeholder = "mg/dL"
            self.DataInputField.keyboardType = UIKeyboardType.numberPad
        }
        else if (row == 1){
            self.DataInputField.placeholder = "systolic"
            self.MedicationInput.isHidden = false
            self.MedicationInput.placeholder = "diastolic"
            self.DataInputField.keyboardType = UIKeyboardType.numberPad
            self.MedicationInput.keyboardType = UIKeyboardType.numberPad
        }
        else if (row == 2){
            self.MedicationInput.isHidden = true
            self.DataInputField.placeholder = "Kcals"
            self.DataInputField.keyboardType = UIKeyboardType.numberPad
        }
        else if (row == 3){
            self.MedicationInput.isHidden = true
            self.DataInputField.placeholder = "grams"
            self.DataInputField.keyboardType = UIKeyboardType.numberPad
        }
        else if (row == 4){
            self.MedicationInput.isHidden = true
            self.DataInputField.placeholder = "bpm"
            self.DataInputField.keyboardType = UIKeyboardType.numberPad
        }
        
        
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
