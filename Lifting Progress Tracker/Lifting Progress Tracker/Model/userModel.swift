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
    var notes: [Note]
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
    
    public func addNotes(notes: [Note]){
        self.notes = SortNotes().sort(notes: notes)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadNote"), object: nil)
    }
    public func addReminders(rem: [Note]){
        self.reminders = rem
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRem"), object: nil)
    }
    public func getReminders()->[Note]{
        return self.reminders
    }
    public func addReminder(rem: Note){
        self.reminders.append(rem)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadRem"), object: nil) // added this
    }
    public func addNote(note: Note){
        self.notes.append(note)
        self.notes = SortNotes().sort(notes: self.notes)
        
        return NoteService().save(note: note) //as! NSDictionary

    }
    
    public func getNotes()-> [Note]{
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
        workouts = SortWorkouts().sort(workouts: self.workouts)
        GraphData.data.SetExercises()
        GraphData.data.SetReps()
        GraphData.data.setTop(data: FilterWorkouts())
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadWorkout"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadW"), object: nil)
    }
    
    func FilterWorkouts()->[Workout]{
        var workouts:[Workout] = []
        for i in userModel.user.getWorkouts(){
            if (i.GetName() ==  GraphSettings.settings.getTop() && i.GetReps() == GraphSettings.settings.getReps()){
                workouts.append(i)
            }
        }
        return workouts
    }
    
    public func setWorkouts(Workouts: [Workout]){
        if(Workouts.isEmpty){
            return
        }
        self.workouts = SortWorkouts().sort(workouts: Workouts)
        
        if (GraphSettings.settings.getTop() == "nul"){
            do{
            try GraphSettings.settings.setTop(type: Workouts[0].GetName())
            try GraphSettings.settings.setReps(reps: Workouts[0].GetReps())
                        }
            catch{}
        }
        GraphData.data.SetExercises()
        GraphData.data.SetReps()
        GraphData.data.setTop(data: FilterWorkouts())
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadWorkout"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadW"), object: nil)
    }
    public func getWorkouts()->[Workout]{
        return self.workouts
    }
}
// access through userModel.user ...


