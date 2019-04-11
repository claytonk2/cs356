//
//  ReminderToEdit.swift
//  Havenly
//
//  Created by Clayton kingsbury on 9/3/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation
class ReminderToEdit{
    static let reminder = ReminderToEdit()
    var text: String
    var date: Date?
    var index: Int
    private init() {
        text = ""
        date = nil
        index = -1
    }
}
