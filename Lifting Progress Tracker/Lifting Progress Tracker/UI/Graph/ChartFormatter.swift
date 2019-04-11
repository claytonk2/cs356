//
//  ChartFormatter.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/17/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation
import Charts

@objc(BarChartFormatter)
class ChartFormatter:NSObject,IAxisValueFormatter{
    
    var labels: [String]!
    init(labels: [String]){
        self.labels = labels
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if (value == -1){
            return labels[0]
        }
        return labels[(Int(value) % labels.count)] // this should be taken out eventually
    }
}
