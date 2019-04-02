//
//  CreateDictionary.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/1/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class CreateDictionary{
    func CreateWorkout(workout: Workout)->NSDictionary{
        let conversion: DateStringConv = DateStringConv()
        var dict : NSDictionary = [
            "name" : workout.GetName(),
            "effort" : workout.GetEffort(),
            "reps" : workout.GetReps(),
            "sets" : workout.GetSets(),
            "weight" : workout.GetWeight(),
            "dateId" : conversion.toString(date: workout.GetDate())
        ]
        
        return dict
    }
    
    func DictToJson(dic: NSDictionary)->Data?{
        var jsonData: Data? = nil
        do{
        jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        }
        catch{
            print("Error in Dict to Json")
            print(dic)
        }
        return jsonData
    }
    
}
