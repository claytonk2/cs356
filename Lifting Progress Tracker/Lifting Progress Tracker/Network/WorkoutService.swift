//
//  WorkoutService.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/2/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class WorkoutService{
    
    func save(sets: String, reps: String, weight: String, name: String, date: Date){
        var workout: Workout = Workout()
        workout.SetSets(sets: Int(sets)!)
        workout.SetReps(reps: Int(reps)!)
        workout.SetWeight(weight: Int(weight)!)
        workout.SetName(Name: name)
        workout.SetDate(date: date)
        FirebaseDatabase.instance.AddWorkout(workout: workout)
    }
    func readAll(){
        return FirebaseDatabase.instance.ReadWorkouts()
    }
}
