//
//  NoteFactory.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/10/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation
class NoteFactory{
    func create(dic: NSDictionary) -> INote{
        if let type: String = try ((dic as! NSDictionary).value(forKey: "type") as? String){
            let val1: String? = (try ((dic as! NSDictionary).value(forKey: "val1") as? String))
            let val2: String? = try ((dic as! NSDictionary).value(forKey: "val2") as? String)
            let date: String? = try ((dic as! NSDictionary).value(forKey: "date") as? String)
            let note: String? = try ((dic as! NSDictionary).value(forKey: "note") as? String)
            let tags: String? = try ((dic as! NSDictionary).value(forKey: "tags") as? String)
            var value:[String] = []
            value.append(val1!)
            if val2 != nil{
                value.append(val2!)
            }
            
            return DataNote(date: (DateStringConv().toDate(date: date!) as! NSDate), text: note!, tags: tags!, value: value, type: type)
        }
        else{
            let date: String? = try ((dic as! NSDictionary).value(forKey: "date") as? String)
            let note: String? = try ((dic as! NSDictionary).value(forKey: "note") as? String)
            let tags: String? = try ((dic as! NSDictionary).value(forKey: "tags") as? String)
            //let tempDate: NSDate = DateStringConv().toDate(date: date!) as! NSDate
            return Note(date: (DateStringConv().toDate(date: date!) as! NSDate), text: note!, tags: tags!)
        }
    }
}
