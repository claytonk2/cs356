//
//  RemFactory.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/21/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
class RemFactory{
    func create(dic: NSDictionary) -> Note{
        
        let date: String? = try ((dic as! NSDictionary).value(forKey: "date") as? String)
        let note: String? = try ((dic as! NSDictionary).value(forKey: "title") as? String)
        //let tags: String? = try ((dic as! NSDictionary).value(forKey: "tags") as? String)
        //let tempDate: NSDate = DateStringConv().toDate(date: date!) as! NSDate
        return Note(date: (DateStringConv().toDate(date: date!) as! NSDate), text: note!, tags: "")
    }

}
