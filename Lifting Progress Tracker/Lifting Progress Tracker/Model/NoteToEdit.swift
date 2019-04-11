//
//  NoteToEdit.swift
//  Havenly
//
//  Created by Clayton kingsbury on 9/7/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation
class NoteToEdit{
    static let note = NoteToEdit()
    var text: String
    var tags: String
    var date: Date?
    var index: Int
    private init() {
        text = ""
        date = nil
        tags = ""
        index = -1
    }
}
