//
//  SortNotes.swift
//  Havenly
//
//  Created by Clayton kingsbury on 9/11/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
class SortNotes{
    func sort(notes: [INote])->[INote]{
        if (notes.count == 1){
            return notes
        }
        var temp: INote = notes[0]
        var retNotes: [INote] = notes
        var sortedAboveIndex: Int = notes.count;
        repeat {
            var lastSwapIndex = 0
            for i in 1...(retNotes.count - 1) {
                if ((retNotes[i - 1] as! Note).getDate().timeIntervalSince1970 > (retNotes[i] as! Note).getDate().timeIntervalSince1970) {
                    temp = retNotes[i]
                    retNotes[i] = retNotes[i-1]
                    retNotes[i-1] = temp
                    lastSwapIndex = i
                }
            }
            sortedAboveIndex = lastSwapIndex
            
        } while (sortedAboveIndex != 0)
        self.display(notes: retNotes)
        return retNotes
    }
    func display(notes: [INote]){
        for note in notes{
            print(DateStringConv().toStringWTimeNS(date: (note as! Note).getDate() as Date))
        }
    }
}
