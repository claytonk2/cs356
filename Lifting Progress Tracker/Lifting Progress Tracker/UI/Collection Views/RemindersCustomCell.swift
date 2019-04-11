//
//  RemindersCustomCell.swift
//  Havenly
//
//  Created by Clayton Kingsbury on 8/8/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import UIKit

class RemindersCustomCell: UITableViewCell {
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
//    var ReminderLabel : String?
//    var ReminderDate : String?
//
//    var reminderView : UITextView {
//        let textView = UITextView()
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        return textView
//    }
//
//    var dateView : UITextView {
//        let textView = UITextView()
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        return textView
//    }
    func updateUI(reminder: Note){
        TitleLabel.text = reminder.getText()
        dateLabel.text = DateStringConv().toStringWTimeNS(date: (reminder.getDate() as! Date))
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        self.addSubview(reminderView)
//        self.addSubview(dateView)
//
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
