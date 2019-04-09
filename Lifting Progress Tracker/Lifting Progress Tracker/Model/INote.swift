//
//  INote.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/9/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
protocol INote{
    var date: NSDate {get}
    var text: String {get}
    var tags: String {get}
    init(date: NSDate, text: String, tags: String)
    func getDate() -> NSDate
    func getText() -> String
    func getTags() -> String
}
