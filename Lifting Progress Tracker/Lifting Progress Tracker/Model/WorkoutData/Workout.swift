//
//  Workout.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 3/21/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class Workout{
    init() {
        reps = 0
        sets = 0
        Name = ""
        Effort = ""
    }
    var reps: Int
    var sets: Int
    var Name: String
    var Effort: String
    func SetReps(reps: Int){
        self.reps = reps
    }
    func SetSets(sets: Int){
        self.sets = sets
    }
    func SetName(Name: String){
        self.Name = Name
    }
    func SetEffort(Effort: String){
        self.Effort = Effort
    }
    func GetReps()-> Int{
        return self.reps
    }
    func GetSets()-> Int{
        return self.sets
    }
    func GetName()-> String{
        return self.Name
    }
    func GetEffort()-> String{
        return self.Effort
    }
}
