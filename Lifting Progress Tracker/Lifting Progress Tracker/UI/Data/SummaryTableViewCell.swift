//
//  SummaryTableViewCell.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/4/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var ToReminderButton: UIButton!
    @IBOutlet weak var ReminderImage: UIImageView!
    @IBOutlet weak var NotesImage: UIImageView!
    @IBOutlet weak var ToNotesButton: UIButton!
    @IBOutlet weak var ReminderCell: UIView!
    @IBOutlet weak var NotesCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ReminderCell.layer.cornerRadius = 8.0
        ReminderCell.layer.masksToBounds = true
        
        NotesCell.layer.cornerRadius = 8.0
        NotesCell.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
