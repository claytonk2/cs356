//
//  NotesCell.swift
//  Havenly
//
//  Created by Benjamin Walter on 8/9/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var MainLineNotesLabel: UILabel!
    @IBOutlet weak var TagsLabel: UILabel!
    
    func updateUI(notesObj: INote) {
        //Drow your cell with values from notesObj
        if let note: Note = notesObj as? Note{
            MainLineNotesLabel.text = note.getText()
            DateLabel.text = DateStringConv().toStringWTimeNS(date: note.getDate() as! Date)
            TagsLabel.text = note.getTags()
            
        }
        else if let note: DataNote = notesObj as? DataNote{
            var values: [String] = note.getValues()
            if values.isEmpty {
                print("Value Error in NotesCell")
                return
            }
            if (values.count == 1){
                MainLineNotesLabel.text = note.getType() + " reading of " + values[0] + ": " +  note.getText()
           
            }
            else{
                 MainLineNotesLabel.text = note.getType() + " reading of " + values[0] + " over " + values[1] + ": " +  note.getText()
            }
            
            DateLabel.text = DateStringConv().toStringWTimeNS(date: note.getDate() as! Date)
            TagsLabel.text = note.getTags()
        }
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
