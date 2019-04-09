//
//  WorkoutSearchService.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/8/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class WorkoutSearchService{
    func search(workouts: [Workout], search: String) -> [Workout]{
        var containTag: [Workout]  = []
        for work in workouts{
            if work.GetName().contains(search){
                containTag.append(work)
            }
            else if (dateSearch(date: work.GetDate(), text: search)){
                containTag.append(work)
            }
        }
        return containTag
    }
    
    func dateSearch(date: Date, text: String)-> Bool{
        if(DateStringConv().toString(date: date).contains(text)){
            return true
        }
        if(DateStringConv().toStringWTime(date: date).contains(text)){
            return true
        }
        if(DateStringConv().toStringWTimeNS(date: date).contains(text)){
            return true
        }
        if(DateStringConv().toStringWTime(date: date).contains(text)){
            return true
        }
        return false
    }
}
