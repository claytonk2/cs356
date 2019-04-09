//
//  WorkoutTableViewCell.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/2/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func updateUI(workout: Workout?) {
        repsLabel.text = String(workout?.GetReps() as! Int)
        weightLabel.text = String(workout?.GetWeight() as! Int)
        exerciseLabel.text = workout?.GetName()
        setsLabel.text = String(workout?.GetSets() as! Int)
        dateLabel.text = DateStringConv().toStringWTimeNS(date: workout?.GetDate())
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
