//
//  GreateConstructor.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/17/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
import Charts
import HealthKitUI
/*
 For Blood Glucose graph, lets make the default range 0-300 (will it autoresize if there’s a point higher than the default?), permanent lines for a low and a high range (like in the picture) (yellow for high and red for low), and if possible, make the data points smaller, solid blue points, and the color changing to yellow if above range and red If below
 */
 

class GraphConstructor{
    
    func readData(data: [Workout]) -> ([Double], [String]){
        var valueArray: [Double] = []
        var timeArray: [String] = []
        
        for sample in data.reversed() {
            valueArray.append(Double(sample.GetWeight()))
            timeArray.append(DateStringConv().toStringWTime(date: sample.GetDate()))
        }
        return (valueArray, timeArray)
    }
    func readData(data: [INote]) -> ([Double], [String]){
        var valueArray: [Double] = []
        var timeArray: [String] = []
        
        for sample in data {
            valueArray.append(0)
            timeArray.append(DateStringConv().toStringWTime(date: (sample as! Note).getDate() as Date))
        }
        return (valueArray, timeArray)
    }
    
    
    func setChart(dataPoints: [String], values: [Double], label: String) -> LineChartData {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
//        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
//        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
//        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        //pieChartDataSet.colors = colors
        
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: label)
        lineChartDataSet.circleHoleRadius = 0
        lineChartDataSet.circleRadius = 5
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartData.setDrawValues(false)
        return lineChartData//lineChartView.data = lineChartData
        
    }
    func setChart(yValuesLineChart: [HKSample], yValuesBarChart: [HKSample], lineUnit: HKUnit, barUnit: HKUnit, labelLine: String, barLine: String)->(XAxis, CombinedChartData) {
        //combinedChartView.noDataText = "Please provide data for the chart."
        
        let (yVals1, yVals2, dates) = GraphDataManipulation().combine(top: yValuesLineChart, bottom: yValuesBarChart, topUnit: lineUnit, botUnit: barUnit)
        
        let lineChartSet = LineChartDataSet(entries: yVals1, label: labelLine)
        lineChartSet.drawValuesEnabled = true
        lineChartSet.circleHoleRadius = 0
        lineChartSet.circleRadius = 5
        lineChartSet.axisDependency = YAxis.AxisDependency.left
        let barChartSet: BarChartDataSet = BarChartDataSet(entries: yVals2, label: barLine)
        barChartSet.axisDependency = YAxis.AxisDependency.right
        barChartSet.colors = [UIColor.red]
        barChartSet.drawValuesEnabled = true
        let xAxis=XAxis()
        let chartFormmater: ChartFormatter = ChartFormatter(labels: dates)
        
        for i in 0..<dates.count {
            chartFormmater.stringForValue(Double(i), axis: xAxis)
        }
        xAxis.valueFormatter = chartFormmater
        xAxis.wordWrapEnabled = true
        
        let data: CombinedChartData = CombinedChartData()//dates)
        data.barData = BarChartData( dataSets: [barChartSet])
        data.lineData = LineChartData(dataSet: lineChartSet)
        //data.
        return (xAxis, data) // combinedChartView.data = data
        
    }
    
    func setChartLines(yValuesLineChart: [HKSample], yValuesBarChart: [HKSample], lineUnit: HKUnit, barUnit: HKUnit, labelLine: String, barLine: String)->(XAxis, CombinedChartData) {
        //combinedChartView.noDataText = "Please provide data for the chart."
        
        let (yVals1, yVals2, dates) = GraphDataManipulation().combineLine(top: yValuesLineChart, bottom: yValuesBarChart, topUnit: lineUnit, botUnit: barUnit)
        GraphData.data.setDates(dates: dates)
        let lineChartSet = LineChartDataSet(entries: yVals1, label: labelLine)
//        lineChartSet.drawValuesEnabled = GraphSettings.settings.getViewValues()
        lineChartSet.circleHoleRadius = 0
//        lineChartSet.circleRadius = CGFloat(GraphSettings.settings.getSize())
        lineChartSet.axisDependency = YAxis.AxisDependency.left
//        lineChartSet.colors = [GraphSettings.settings.getTopColorLine()]
//        lineChartSet.circleColors = [GraphSettings.settings.getTopColorDot()]
        let barChartSet: LineChartDataSet = LineChartDataSet(entries: yVals2, label: barLine)
        barChartSet.axisDependency = YAxis.AxisDependency.right
//        barChartSet.colors = [GraphSettings.settings.getBottomColorLine()]
//        barChartSet.circleColors = [GraphSettings.settings.getBottomColorDot()]
//        barChartSet.drawValuesEnabled = true
//        barChartSet.drawValuesEnabled = GraphSettings.settings.getViewValues()
        barChartSet.circleHoleRadius = 0
//        barChartSet.circleRadius = GraphSettings.settings.getSize()
        let xAxis=XAxis()
        let chartFormmater: ChartFormatter = ChartFormatter(labels: dates)
        
        for i in 0..<dates.count {
            chartFormmater.stringForValue(Double(i), axis: xAxis)
        }
        xAxis.valueFormatter = chartFormmater
        xAxis.wordWrapEnabled = true
        
        let data: CombinedChartData = CombinedChartData()//dates)
//        data.barData = BarChartData( dataSets: [barChartSet])
        data.lineData = LineChartData(dataSets: [lineChartSet, barChartSet])
        //data.
        return (xAxis, data) // combinedChartView.data = data
        
    }

    
    func ConstructGraph(label: String, data: [Workout])->(XAxis, LineChartData){
        //let ll = ChartLimitLine(limit: 10.0, label: "Target")
        // barChartView.rightAxis.addLimitLine(ll)
        let (valueArray, timeArray) = self.readData(data: data)
        let retData: LineChartData = self.setChart(dataPoints: timeArray, values: valueArray, label: label)
        retData.setDrawValues(false)
        let xAxis=XAxis()
        let chartFormmater: ChartFormatter = ChartFormatter(labels: timeArray)
        
        for i in 0..<timeArray.count {
            chartFormmater.stringForValue(Double(i), axis: xAxis)
        }
        
        xAxis.valueFormatter = chartFormmater
        xAxis.wordWrapEnabled = true
        return (xAxis, retData)
    }
    
    func ConstructSumarryNoteGraph(label: String, data: [INote])->(XAxis, LineChartData){
        //let ll = ChartLimitLine(limit: 10.0, label: "Target")
        // barChartView.rightAxis.addLimitLine(ll)
        let (valueArray, timeArray) = self.readData(data: data)
        let retData: LineChartData = self.setChart(dataPoints: timeArray, values: valueArray, label: label)
        retData.setDrawValues(false)
        let xAxis=XAxis()
        let chartFormmater: ChartFormatter = ChartFormatter(labels: timeArray)
        
        for i in 0..<timeArray.count {
            chartFormmater.stringForValue(Double(i), axis: xAxis)
        }
        
        xAxis.valueFormatter = chartFormmater
        xAxis.wordWrapEnabled = true
        return (xAxis, retData)
    }
    
    
    
}

