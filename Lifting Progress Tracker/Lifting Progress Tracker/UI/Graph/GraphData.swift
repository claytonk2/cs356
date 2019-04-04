//
//  GraphData.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/24/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation

class GraphData{
    static let data: GraphData = GraphData()
    var topData: [Workout] = []
    var bottomData: [Double] = []
    func setTop(data: [Workout]){
        self.topData = data
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    func setBottom(data: [Double]){
        self.bottomData = data
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    func getData()->[Workout]{
        return self.topData
    }
    func getBottom()->[Double]{
        return self.bottomData
    }
    var dates: [String] = []
    func getDates()->[String]{
        return self.dates
    }
    func setDates(dates: [String]){
        self.dates = dates
    }
}
