//
//  DataNote.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/9/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation
class DataNote: INote{
    var date: NSDate
    
    var text: String
    
    var tags: String
    var value: [String]
    var type: String
    required init(date: NSDate, text: String, tags: String) {
        self.date = date
        self.text = text
        self.tags = tags
        self.value = []
        self.type = ""
    }
    init(date: NSDate, text: String, tags: String, value: [String], type: String) {
        self.date = date
        self.text = text
        self.tags = tags
        self.value = value
        self.type = type
    }
    
    func getDate() -> NSDate {
        return self.date
    }
    
    func getText() -> String {
        return self.text
    }
    
    func getTags() -> String {
        return self.tags
    }
    func getValues()->[String]{
        return self.value
    }
    func getType()->String{
        return self.type
    }
    
}
