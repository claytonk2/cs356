//
//  GraphDataManipulation.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/23/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
import HealthKitUI
import Charts

class GraphDataManipulation{
    
    
    func combine(top: [HKSample], bottom: [HKSample], topUnit: HKUnit, botUnit: HKUnit )->([ChartDataEntry], [BarChartDataEntry], [String]){
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [BarChartDataEntry] = [BarChartDataEntry]()
        var timeVals: [String] = []
        var finished: Bool = false
        var i: Int = 0
        var t: Int = 0
        var index: Int = 0
        if (top.count == 0){
            let (val, time) = self.missingInfo(data: bottom, unit: botUnit, dataEntry: yVals2)
            yVals2 = val
            timeVals = time
        }
        else if (bottom.count == 0){
            let (val, time) = self.missingInfo(data: top, unit: topUnit, dataEntry: yVals1)
            yVals1 = val
            timeVals = time
        }
        else{ // seperate them out
            
            while( !finished) {
                if(i >= top.count && t < bottom.count ){ // error
                    //BarChartDataEntry(
                    yVals2.append(BarChartDataEntry(x: Double(index), y: (bottom[t] as! HKQuantitySample).quantity.doubleValue(for: botUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: bottom[t].startDate))
                    t = t + 1
                }
                else if (i >= top.count && t >= bottom.count){
                    finished = true
                }
                else if (t >= bottom.count && i < top.count){
                    yVals1.append(ChartDataEntry(x: Double(index), y: (top[i] as! HKQuantitySample).quantity.doubleValue(for: topUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: top[i].startDate))
                    i = i + 1
                }
                else if(i >= top.count && t < bottom.count || (top[i].startDate.compare(bottom[t].startDate) == .orderedDescending )){ // error
                    //BarChartDataEntry(
                    yVals2.append(BarChartDataEntry(x: Double(index), y: (bottom[t] as! HKQuantitySample).quantity.doubleValue(for: botUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: bottom[t].startDate))
                    t = t + 1
                }
                else if (t >= bottom.count && i < top.count || (top[i].startDate.compare(bottom[t].startDate) == .orderedAscending )){
                    yVals1.append(ChartDataEntry(x: Double(index), y: (top[i] as! HKQuantitySample).quantity.doubleValue(for: topUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: top[i].startDate))
                    i = i + 1
                }
                else if (top[i].startDate.compare(bottom[t].startDate) == .orderedSame){
                    yVals1.append(ChartDataEntry(x: Double(index), y: (top[i] as! HKQuantitySample).quantity.doubleValue(for: topUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: top[i].startDate))
                    //BarChartDataEntry(
                    yVals2.append(BarChartDataEntry(x: Double(index), y: (bottom[t] as! HKQuantitySample).quantity.doubleValue(for: botUnit)))
                    i = i + 1
                    t = t + 1
                }
                else{
                    finished = true
                }
                index = index + 1
            }
        }
        return (yVals1, yVals2, timeVals)
    }
    func missingInfo(data: [HKSample], unit: HKUnit, dataEntry: [ChartDataEntry])->([ChartDataEntry], [String]){
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var timeVals: [String] = []
        
        for i in 0..<data.count{
            yVals1.append(ChartDataEntry(x: Double(i), y: (data[i] as! HKQuantitySample).quantity.doubleValue(for: unit)))
            timeVals.append(DateStringConv().toStringWTime(date: data[i].startDate))
        }
        return (yVals1, timeVals)
    }
    func missingInfo(data: [HKSample], unit: HKUnit, dataEntry: [BarChartDataEntry])->([BarChartDataEntry], [String]){
        var yVals2 : [BarChartDataEntry] = [BarChartDataEntry]()
        var timeVals: [String] = []
        var finished: Bool = false
        for i in 0..<data.count{
            yVals2.append(BarChartDataEntry(x: Double(i), y: (data[i] as! HKQuantitySample).quantity.doubleValue(for: unit)))
            timeVals.append(DateStringConv().toStringWTime(date: data[i].startDate))
        }
        return (yVals2, timeVals)
    }
    func combineLine(top: [HKSample], bottom: [HKSample], topUnit: HKUnit, botUnit: HKUnit, labelOne: String = "", labelTwo: String = "")->([ChartDataEntry], [ChartDataEntry], [String]){
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        var timeVals: [String] = []
        var finished: Bool = false
        var i: Int = 0
        var index: Int = 0
        var t: Int = 0
        if (top.count == 0){
            let (val, time) = self.missingInfo(data: bottom, unit: botUnit, dataEntry: yVals2)
            yVals2 = val
            timeVals = time
        }
        else if (bottom.count == 0){
            let (val, time) = self.missingInfo(data: top, unit: topUnit, dataEntry: yVals1)
            yVals1 = val
            timeVals = time
        }
        else{ // seperate them out
            
            while( !finished) {
                if(i >= top.count && t < bottom.count ){ // error
                    //BarChartDataEntry(
                    yVals2.append(ChartDataEntry(x: Double(index), y: (bottom[t] as! HKQuantitySample).quantity.doubleValue(for: botUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: bottom[t].startDate))
                    t = t + 1
                }
                else if (i >= top.count && t >= bottom.count){
                    finished = true
                }
                else if (t >= bottom.count && i < top.count){
                    yVals1.append(ChartDataEntry(x: Double(index), y: (top[i] as! HKQuantitySample).quantity.doubleValue(for: topUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: top[i].startDate))
                    i = i + 1
                }
                else if(i >= top.count && t < bottom.count || (top[i].startDate.compare(bottom[t].startDate) == .orderedDescending )){ // error
                    //BarChartDataEntry(
                    yVals2.append(ChartDataEntry(x: Double(index), y: (bottom[t] as! HKQuantitySample).quantity.doubleValue(for: botUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: bottom[t].startDate))
                    t = t + 1
                }
                else if (t >= bottom.count && i < top.count || (top[i].startDate.compare(bottom[t].startDate) == .orderedAscending )){
                    yVals1.append(ChartDataEntry(x: Double(index), y: (top[i] as! HKQuantitySample).quantity.doubleValue(for: topUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: top[i].startDate))
                    i = i + 1
                }
                else if (top[i].startDate.compare(bottom[t].startDate) == .orderedSame){
                    yVals1.append(ChartDataEntry(x: Double(index), y: (top[i] as! HKQuantitySample).quantity.doubleValue(for: topUnit)))
                    timeVals.append(DateStringConv().toStringWTime(date: top[i].startDate))
                    //BarChartDataEntry(
                    yVals2.append(ChartDataEntry(x: Double(index), y: (bottom[t] as! HKQuantitySample).quantity.doubleValue(for: botUnit)))
                    i = i + 1
                    t = t + 1
                }
                else{
                    finished = true
                }
                index = index + 1
            }
        }
        for val in yVals1{
            val.accessibilityValue = labelOne
        }
        for val in yVals2{
            val.accessibilityValue = labelTwo
        }
        return (yVals1, yVals2, timeVals)
    }
    
    
}
