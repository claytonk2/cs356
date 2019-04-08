//
//  FirebaseDatabase.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 3/26/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
import Firebase
class FirebaseDatabase{
    static let instance: FirebaseDatabase = FirebaseDatabase()
    var ref: DatabaseReference!
    private init(){
        ref = Database.database().reference()
    }
    public func AddWorkout(workout: Workout){ ///todo fix this
        var dict: NSDictionary = CreateDictionary().CreateWorkout(workout: workout)
        let userID = Auth.auth().currentUser?.uid
        self.ref.child(userID!).setValue("username") // need to set or create ref
        // chck if on exists
        guard let dateKey:Any? = ref.child("users/\(userID)/workoutDate").childByAutoId().key else { return }
        guard let key:Any? = ref.child("users/\(userID)/workouts\(dateKey)/workouts").childByAutoId().key else { return }
        let workoutDate = [ "date": dict["dateId"]]
        //let workouts = dict
        let childUpdates = ["/users/\(userID)/workoutDate/\(dateKey)/": workoutDate,
                            "/users/\(userID)/workouts/\(key)/": dict] as [String : Any]
        ref.updateChildValues(childUpdates)
    }
    
    public func ReadWorkouts(){
        var workouts: [Workout] = [Workout]()
        let userID = Auth.auth().currentUser?.uid
        let myWorkouts = (ref.child("users/\(userID)").child("workouts").queryOrdered(byChild: "name")) // check this
        myWorkouts.observe(DataEventType.value, with: { (snapshot) in
            // Get user value
            print(snapshot.children.allObjects)
            for child in snapshot.children {
//                let valueReps = (child as! DataSnapshot).value as? NSDictionary
                let reps = ((child as! DataSnapshot).value as? NSDictionary)?["sets"] as? Int ?? 0
                let sets = ((child as! DataSnapshot).value as? NSDictionary)?["reps"] as? Int ?? 0
                let weight = ((child as! DataSnapshot).value as? NSDictionary)?["weight"] as? Int ?? 0
                let name = ((child as! DataSnapshot).value as? NSDictionary)?["name"] as? String ?? ""
                let effort = ((child as! DataSnapshot).value as? NSDictionary)?["effort"] as? String ?? ""
                let date: Date = DateStringConv().toDate(date: ((child as! DataSnapshot).value as? NSDictionary)?["dateId"] as? String ?? "")
                workouts.append(Workout(reps: reps, sets: sets, weight: weight, name: name, effort: effort, date: date))
                
            }
            userModel.user.setWorkouts(Workouts: workouts)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    public func AddNote(note: Note){ ///todo fix this
        var dict: NSDictionary = CreateDictionary().CreateNote(note: note)
        let userID = Auth.auth().currentUser?.uid
        self.ref.child(userID!).setValue("username") // need to set or create ref
        // chck if on exists
        guard let dateKey:Any? = ref.child("users/\(userID)/noteDate").childByAutoId().key else { return }
        guard let key:Any? = ref.child("users/\(userID)/notes").childByAutoId().key else { return }
        let workoutDate = [ "date": dict["date"]]
        //let workouts = dict
        let childUpdates = ["/users/\(userID)/noteDate/\(dateKey)/": workoutDate,
                            "/users/\(userID)/notes/\(key)/": dict] as [String : Any]
        ref.updateChildValues(childUpdates)
    }
    
    public func ReadNotes(){
        var notes: [Note] = [Note]()
        let userID = Auth.auth().currentUser?.uid
        let myNotes = (ref.child("users/\(userID)").child("notes").queryOrdered(byChild: "name")) // check this
        myNotes.observe(DataEventType.value, with: { (snapshot) in
            // Get user value
            print(snapshot.children.allObjects)
            for child in snapshot.children {
                //                let valueReps = (child as! DataSnapshot).value as? NSDictionary
                let text = ((child as! DataSnapshot).value as? NSDictionary)?["text"] as? String ?? ""
                let tags = ((child as! DataSnapshot).value as? NSDictionary)?["tags"] as? String ?? ""
                let date: Date = DateStringConv().toDate(date: ((child as! DataSnapshot).value as? NSDictionary)?["date"] as? String ?? "")
                notes.append(Note(date: date as NSDate, text: text, tags: tags))
                
            }
            userModel.user.addNotes(notes: notes)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
//        return notes
    }
    
}

