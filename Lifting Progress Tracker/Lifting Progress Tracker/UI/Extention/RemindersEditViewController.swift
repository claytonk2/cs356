//
//  RemindersEditViewController.swift
//  Havenly
//
//  Created by Benjamin Walter on 8/29/18.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import EventKitUI

class RemindersEditViewController: UITableViewController{

    var DatePicker = UIDatePicker()
    var service: ReminderService = ReminderService()
    
    @IBOutlet weak var DateLabel: UITextField!
    @IBOutlet weak var ReminderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.hideKeyboardWhenTappedAround()
        
        DateLabel.placeholder = DateStringConv().toStringWTimeNS(date: ReminderToEdit.reminder.date)

        DatePicker.date = ReminderToEdit.reminder.date as! Date
        
        ReminderLabel.text = ReminderToEdit.reminder.text

        createDatePicker()
        
        // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
            granted, error in
            if granted {
                print("Approval granted to send notifications")
            } else {
                print("error")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    
        removeNotification()
        
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

    @IBAction func EditingComplete(_ sender: Any) {
        scheduleNotification()
        if EKEventStore.authorizationStatus(for: EKEntityType.reminder) == EKAuthorizationStatus.authorized{
            let eventStore: EKEventStore = EKEventStore()
            let newReminder: EKReminder = EKReminder(eventStore: eventStore)
            newReminder.title = ReminderLabel.text
            let date: NSDate = DatePicker.date as NSDate
            let components: DateComponents = DatePicker.calendar.dateComponents(in: TimeZone.current, from: DatePicker.date)
            newReminder.dueDateComponents = components
            do {
                
                try eventStore.save(newReminder, commit: true)
                
                var dic = service.store(note: Note(date: date, text: ReminderLabel.text!, tags: ""))
                var check: NSDictionary = (dic as! NSDictionary)
                if let error: String = try ((dic as! NSDictionary).value(forKey: "error") as? String){
                    let alert = UIAlertController(title: "Notification Issue", message: "An error has occurred while creating this notification.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }catch{
                print("Error creating and saving new reminder : \(error)")
            }
        }
        
        userModel.user.reminders[ReminderToEdit.reminder.index].date = DatePicker.date as NSDate
        userModel.user.reminders[ReminderToEdit.reminder.index].text = ReminderLabel.text!
        UpdateReminder().edit(rem: Note(date: ReminderToEdit.reminder.date as! NSDate, text: ReminderToEdit.reminder.text, tags: ""), newRem: Note(date: DatePicker.date as NSDate, text: ReminderLabel.text!, tags: ""))// contact server
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = ReminderLabel.text!
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default()
        
        // Configure the recurring date.
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,], from: DatePicker.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
            print(error?.localizedDescription as Any )
            }
        }
    }
    let requestIdentifier = "identifier"
    
    func removeNotification(){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [ReminderToEdit.reminder.text])
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
extension RemindersEditViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}

extension RemindersEditViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RemindersEditViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
