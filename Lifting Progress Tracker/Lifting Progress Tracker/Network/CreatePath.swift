//
//  CreatePath.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 3/26/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class CreatePath{
    public func CreateUserNamePath()->String{
        return "users/" + userModel.user.getUserId() + "username"
    }
    public func Workout(date: String)->String{
        return "users/" + userModel.user.getUserId() + "/workoutDate/" + date + "/workouts"
    }
    public func WorkoutDates()->String{
        return "users/" + userModel.user.getUserId() + "/workoutDates/"
    }
    public func Notes(date: String)->String{
        return "users/" + userModel.user.getUserId() + "/workoutDate/" + date + "/notes"
    }
}
