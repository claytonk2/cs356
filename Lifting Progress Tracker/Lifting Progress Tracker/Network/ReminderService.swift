//
//  ReminderService.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/8/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class ReminderService{
    func save(reminder: Note){
        FirebaseDatabase.instance.AddReminder(reminder: reminder)
        userModel.user.addReminder(rem: reminder)
    }
    func readAll(){
        do {
            FirebaseDatabase.instance.ReadReminders()
            //            return true
        }
        catch{
            userModel.user.addReminders(rem: [])
        }
    }
}
