//
//  ChartFormatter.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/17/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
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
        return labels[(Int(value) % labels.count)] // this should be taken out eventually
    }
}
