//
//  GraphIndexToNote.swift
//  Havenly
//
//  Created by Clayton kingsbury on 9/10/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
class GraphIndexToNote{
    func calculate(date: NSDate)->Int{
        var lowestIndex: Int = 0
        var count: Int = 0
        var lowestVal: Double = DBL_MAX
        for note in userModel.user.getNotes(){ // does it need to be reversed 
            var temp: Double = abs(note.getDate().timeIntervalSince1970 - date.timeIntervalSince1970)
            if (temp < lowestVal){
                lowestVal = temp
                lowestIndex = count
            }
            count = count + 1
        }
        return lowestIndex
    }
}
