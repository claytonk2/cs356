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
        weight = 0
        date = Date()
    }
    init(reps: Int, sets: Int, weight: Int, name: String, effort:String, date: Date) {
        self.reps = reps
        self.sets = sets
        Name = name
        Effort = effort
        self.weight = weight
        self.date = date
    }
    var reps: Int
    var sets: Int
    var Name: String
    var Effort: String
    var weight: Int
    var date: Date
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
    func GetWeight()->Int{
        return self.weight
    }
    func SetWeight(weight: Int){
        self.weight = weight
    }
    func GetDate()->Date{
        return date
    }
    func SetDate(date: Date){
        self.date = date
    }
}
