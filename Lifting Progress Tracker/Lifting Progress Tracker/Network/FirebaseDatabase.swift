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
        self.ref.child(CreatePath().CreateUserNamePath()).setValue("username")
    }
    
}

