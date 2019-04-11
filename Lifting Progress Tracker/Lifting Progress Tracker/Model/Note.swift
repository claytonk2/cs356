//
//  Note.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/7/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation
class Note: INote {
    var date: NSDate
    var text: String
    var tags: String
    required init(date: NSDate, text: String, tags: String) {
        self.date = date
        self.text = text
        self.tags = tags
    }
    func getDate() -> NSDate{
        return self.date
    }
    func getText() -> String{
        return self.text
    }
    func getTags() -> String{
        return self.tags
    }
}
