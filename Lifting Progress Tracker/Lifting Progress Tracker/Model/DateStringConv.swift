//
//  DateStringConv.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/10/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
class DateStringConv{
    func toDate(date: String)-> Date{
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy, H:mm"
        
        //`date(from:)` returns an optional so make sure you unwrap when using.
        var dateFromString: Date? = dateFormatter.date(from: date)
        
        return dateFromString!
    }
    
    func toDateFromGraph(date: String)-> Date{
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d, \nh:mm a"
        
        //`date(from:)` returns an optional so make sure you unwrap when using.
        var dateFromString: Date? = dateFormatter.date(from: date)
        
        return dateFromString!
    }
    func toString(date: Date?) -> String{
        var formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy, H:mm"
        guard let unwrappedDate = date else { return "" }
        
        //Using the dateFromString variable from before.
        let stringDate: String = formatter.string(from: date!)
        return stringDate
    }
    func toStringWTime(date: Date?) -> String{
        var formatter = DateFormatter()
        formatter.dateFormat = "M/d, \nh:mm a"
        guard let unwrappedDate = date else { return "" }
        
        //Using the dateFromString variable from before.
        let stringDate: String = formatter.string(from: date!)
        return stringDate
    }
    func toStringWTimeNS(date: Date?) -> String{
        var formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        guard let unwrappedDate = date else { return "" }
        
        //Using the dateFromString variable from before.
        let stringDate: String = formatter.string(from: date!)
        return stringDate
    }
}
