//
//  NotesEditViewController.swift
//  Havenly
//
//  Created by Benjamin Walter on 9/4/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import UIKit

    var DatePicker = UIDatePicker()

class NotesEditViewController: UITableViewController {

    @IBOutlet weak var TagTextView: UITextView!
    @IBOutlet weak var NoteTextView: UITextView!
    @IBOutlet weak var DateLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.hideKeyboardWhenTappedAround()
        
        DateLabel.placeholder = DateStringConv().toStringWTimeNS(date: NoteToEdit.note.date)
        
        DatePicker.date = NoteToEdit.note.date as! Date
        
        TagTextView.text = NoteToEdit.note.tags
        NoteTextView.text = NoteToEdit.note.text
        
        self.hideDatePicker()
        
        createDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker(){
        DateLabel.inputView = DatePicker
        DatePicker.datePickerMode = .dateAndTime
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(completed))
        toolBar.setItems([doneButton], animated: true)
        DateLabel.inputAccessoryView = toolBar
    }
    
    @objc func completed(){
        DateLabel.text = DateStringConv().toStringWTimeNS(date: DatePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func FinishedEditing(_ sender: Any) {
        
        completed()
        (userModel.user.notes[NoteToEdit.note.index] as! Note).date  = DatePicker.date as NSDate
        (userModel.user.notes[NoteToEdit.note.index] as! Note).tags  = TagTextView.text!
        (userModel.user.notes[NoteToEdit.note.index] as! Note).text  = NoteTextView.text!
        // contact the server
        UpdateNotes().edit(note: Note(date: NoteToEdit.note.date as! NSDate, text: NoteToEdit.note.text, tags: NoteToEdit.note.tags), newNote: userModel.user.notes[NoteToEdit.note.index] as! Note)
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        navigationController?.popViewController(animated: true)
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
extension UITableViewController
{
    func hideDatePicker()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UITableViewController.dismissDatePicker))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissDatePicker()
    {
        view.endEditing(true)
    }
}
extension NotesEditViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NotesEditViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
