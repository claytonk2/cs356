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
        guard let key:Any? = ref.child("/workouts\(dateKey)/workouts").childByAutoId().key else { return }
        let workoutDate = [ "date": dict["dateId"]]
        //let workouts = dict
        let childUpdates = ["/users/\(userID)/workoutDate/\(dateKey)/": workoutDate,
                            "/users/\(userID)/workouts\(dateKey)/workouts/\(key)/": dict] as [String : Any]
        ref.updateChildValues(childUpdates)
    }
    
}

