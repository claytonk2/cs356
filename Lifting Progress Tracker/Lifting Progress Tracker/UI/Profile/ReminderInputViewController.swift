//
//  ReminderInputViewController.swift
//  Havenly
//
//  Created by Clayton Kingsbury on 8/2/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import EventKitUI

class ReminderInputViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate{

    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var SubmitReminder: UIButton!
    @IBOutlet weak var ReminderTextBox: UITextField!
    @IBOutlet weak var DateTimePicker: UIDatePicker!
    var service: ReminderService = ReminderService()

    @IBAction func SubmitReminder(_ sender: UIButton) {


//        performSegue(withIdentifier: "ReminderInputSegue", sender: ReminderLabel)
//        NotificationCenter.default.post(name: .saveDateTime, object: self)

//        var eventStore: EKEventStore = EKEventStore()
        let dic = service.save(reminder: Note(date: DateTimePicker!.date as NSDate, text: ReminderTextBox.text!, tags: ""))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRem"), object: nil)
        scheduleNotification()

        if EKEventStore.authorizationStatus(for: EKEntityType.reminder) == EKAuthorizationStatus.authorized{
            let eventStore: EKEventStore = EKEventStore()
            let newReminder: EKReminder = EKReminder(eventStore: eventStore)
            newReminder.title = ReminderTextBox.text
            let date: NSDate = DateTimePicker!.date as NSDate
            let components: DateComponents = DateTimePicker.calendar.dateComponents(in: TimeZone.current, from: DateTimePicker.date)
            newReminder.dueDateComponents = components
            do {

               try eventStore.save(newReminder, commit: true)


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

//        
//
        dismiss(animated: true, completion: nil)


//        performSegue(withIdentifier: "ReminderInputSegue", sender: textFieldString)

    }

    @IBAction func TouchOutside(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: DateTimePicker.date)
    }

    var formattedTime: String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: DateTimePicker.date)
    }
    //For passing data back to Reminders List
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let viewController = segue.destination as? RemindersViewController
        if let viewController = viewController
        {
            let list = sender
            if let list = list as? [String]
            {
                viewController.list = list
            }
        }
    }

    override func viewDidLoad() {
    super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
            granted, error in
            if granted {
                print("Approval granted to send notifications")
            } else {
                print("error")
            }
        }

        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate


    self.hideKeyboardWhenTappedAround()

    self.RoundedView.layer.cornerRadius = 15
    self.RoundedView.layer.masksToBounds = true

    self.ReminderTextBox.layer.borderColor = UIColor.lightGray.cgColor
    self.ReminderTextBox.layer.borderWidth = 1
    }

    func scheduleNotification() {

        let content = UNMutableNotificationContent()
        content.title = ReminderTextBox.text!
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        // Configure the recurring date.

        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,], from: DateTimePicker.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request){(error) in

            if (error != nil){

                print(error?.localizedDescription as Any )
            }
        }

    }

    let requestIdentifier = "identifier"

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

}

extension ReminderInputViewController: UNUserNotificationCenterDelegate {

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

extension ReminderInputViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReminderInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



