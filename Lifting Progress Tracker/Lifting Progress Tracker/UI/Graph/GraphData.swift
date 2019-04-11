//
//  GraphData.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/24/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation

class GraphData{
    static let data: GraphData = GraphData()
    var topData: [Workout] = []
    var bottomData: [Double] = []
    var exercises: [String] = []
    var reps: [String] = []
    func setTop(data: [Workout]){
        self.topData = data
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    func setBottom(data: [Double]){
        self.bottomData = data
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    func SetExercises(){
        var exercises: [String] = []
        let workouts: [Workout] =  userModel.user.getWorkouts()
        for i in workouts{
            if(!exercises.contains(i.GetName())){
                exercises.append(i.GetName())
            }
        }
        self.exercises = exercises
    }
    func SetReps(){
        var reps: [String] = []
        let workouts: [Workout] =  userModel.user.getWorkouts()
        for i in workouts{
            if(!reps.contains(i.GetReps().description) && i.GetName() == GraphSettings.settings.getTop()){
                reps.append(i.GetReps().description)
            }
        }
        self.reps = reps
    }
    func GetExercises()->[String]{
        return self.exercises
    }
    func GetReps()->[String]{
        return self.reps
    }
    func getData()->[Workout]{
        return self.topData
    }
    func getBottom()->[Double]{
        return self.bottomData
    }
    var dates: [String] = []
    func getDates()->[String]{
        return self.dates
    }
    func setDates(dates: [String]){
        self.dates = dates
    }
}
