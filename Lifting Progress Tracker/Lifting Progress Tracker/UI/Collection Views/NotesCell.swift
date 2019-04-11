//
//  NotesCell.swift
//  Havenly
//
//  Created by Clayton Kingsbury on 8/9/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var MainLineNotesLabel: UILabel!
    @IBOutlet weak var TagsLabel: UILabel!
    
    func updateUI(notesObj: Note) {
        //Drow your cell with values from notesObj
        if let note: Note = notesObj as? Note{
            MainLineNotesLabel.text = note.getText()
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
