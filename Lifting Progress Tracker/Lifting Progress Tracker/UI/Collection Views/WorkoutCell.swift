//
//  WorkoutCell.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/1/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
    
    
    
    func updateUI(notesObj: Workout?) {
        //Drow your cell with values from notesObj
//        if let note: Note = notesObj as? Note{
//            MainLineNotesLabel.text = note.getText()
//            DateLabel.text = DateStringConv().toStringWTimeNS(date: note.getDate() as! Date)
//            TagsLabel.text = note.getTags()
//
//        }
//        else if let note: DataNote = notesObj as? DataNote{
//            var values: [String] = note.getValues()
//            if values.isEmpty {
//                print("Value Error in NotesCell")
//                return
//            }
//            if (values.count == 1){
//                MainLineNotesLabel.text = note.getType() + " reading of " + values[0] + ": " +  note.getText()
//
//            }
//            else{
//                MainLineNotesLabel.text = note.getType() + " reading of " + values[0] + " over " + values[1] + ": " +  note.getText()
//            }
//
//            DateLabel.text = DateStringConv().toStringWTimeNS(date: note.getDate() as! Date)
//            TagsLabel.text = note.getTags()
//        }
        // MainLineNotesLabel.text = TotalNotesModel.notes.MainLineNotes
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

