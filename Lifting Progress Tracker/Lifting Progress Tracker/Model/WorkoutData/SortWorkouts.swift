//
//  SortWorkouts.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/7/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class SortWorkouts{
    func sort(workouts: [Workout])->[Workout]{
        if (workouts.count == 1){
            return workouts
        }
        var temp: Workout = workouts[0]
        var retWorkout: [Workout] = workouts
        var sortedAboveIndex: Int = workouts.count;
        repeat {
            var lastSwapIndex = 0
            for i in 1...(retWorkout.count - 1) {
                if (retWorkout[i - 1].GetDate().timeIntervalSince1970 > retWorkout[i].GetDate().timeIntervalSince1970) {
                    temp = retWorkout[i]
                    retWorkout[i] = retWorkout[i-1]
                    retWorkout[i-1] = temp
                    lastSwapIndex = i
                }
            }
            sortedAboveIndex = lastSwapIndex
            
        } while (sortedAboveIndex != 0)
//        self.display(notes: retWorkout)
        return retWorkout
    }
    func display(notes: [INote]){
        for note in notes{
            print(DateStringConv().toStringWTimeNS(date: (note as! Note).getDate() as Date))
        }
    }
}
