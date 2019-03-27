//
//  userModel.swift
//  Startup_App
//
//  Created by Clayton kingsbury on 7/9/18.
//  Copyright © 2018 Clayton kingsbury. All rights reserved.
//

//let gluco = reading as? HKQuantitySample
//if let bg = gluco?.quantity {
//    print(bg)
//} // this is how you use the values


import Foundation
import HealthKit

class userModel {
    static let user = userModel()
    var username: String
    var password: String
    var firstName: String
    var lastName: String
    var workouts: [Workout]
    var notes: [INote]
    var reminders: [Note]
    var userId: String
    var userCredentials: String
    private init(){
        username = "test_fail"
        password = "test_fail"
        firstName = "test_fail"
        lastName = "test_fail"
        notes = []
        reminders = []
        userId = ""
        workouts = []
        userCredentials = ""
    }
    
    public func addNotes(notes: [INote]){
        self.notes = SortNotes().sort(notes: notes)
    }
    public func addReminders(rem: [Note]){
        self.reminders = rem
    }
    public func getReminders()->[Note]{
        return self.reminders
    }
    public func addReminder(rem: Note){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRem"), object: nil) // added this
        self.reminders.append(rem)
    }
    public func addNote(note: INote) -> NSDictionary{
        self.notes.append(note)
        self.notes = SortNotes().sort(notes: self.notes)
//        if let nNote: Note = note as? Note{
//            return StoreNote().store(note: nNote) as! NSDictionary
//        }
//        else if let dNote: DataNote = note as? DataNote{
//            return StoreNote().store(note: dNote) as! NSDictionary
//        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadNote"), object: nil)
        return NSDictionary()
    }
    public func getNotes()-> [INote]{
        return self.notes
    }
    public func setUsername(username: String){
        self.username = username
    }
    public func setUserId(userId: String){
        self.userId = userId
    }
    public func getUserId()-> String{
        return self.userId
    }
    public func setUserCredentials(userId: String){
        self.userCredentials = userId
    }
    public func getUserCredentials()-> String{
        return self.userCredentials
    }
    public func setPassword(password: String){
        self.password = password
    }
    public func setFirstName(name: String){ 
        self.firstName = name
    }
    public func setLastName(name: String){
        self.lastName = name
    }
    
    public func addWorkout(Workout: Workout){
        self.workouts.append(Workout)
    }
    public func getWorkouts()->[Workout]{
        return self.workouts
    }
}
// access through userModel.user ...


