//
//  GraphSettings.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/22/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
import Charts

class GraphSettings{
    static let settings = GraphSettings()


    //var labelPosition: = .bottom // DataGraph.xAxis.labelPosition = .bottom still need to see this. could use ifs
    var rightAxis: Bool = true//DataGraph.rightAxis.enabled = false
    func getRAxis()->Bool{
        return self.rightAxis
    }
    func setRAxis(view: Bool){
        self.rightAxis = view
    }
    //DataGraph.data = data
//    var visibleMax: Int = 6 //DataGraph.setVisibleXRangeMaximum(6) //20 BEING THE HIGHEST POINT YOU WANT SHOWN, YOU CAN SCROLL ABOVE IR BELOW THAT
//    func getVisibleMax()->Int{
//        return self.visibleMax
//    }

//    func setVMax(max: Int){
//        self.visibleMax = max
//    }
    //BuildGraphView.moveViewToY(6) //8 BEING THE HIGHEST VALUE YOU WANT TO REACH AT A POINT
    var dragEnabled: Bool = true // DataGraph.dragEnabled = true
    func getDragEnabled()->Bool{
        return self.dragEnabled
    }
    func setDragEnabled(view: Bool){
        self.dragEnabled = view
    }
    var zoom: Bool = true //DataGraph.doubleTapToZoomEnabled = true
    func getZoom()->Bool{
        return self.zoom
    }
    func setZoom(view: Bool){
        self.zoom = view
    }

    var topGraph: String = "Blood Glucose" //"Blood Glucose","Blood Pressure","Calories","Carbs","Heart Rate","Medication"
    var bottomGraph: String = "Heart Rate"
    var topColorDot: UIColor = UIColor(named: "CustomBlue")!
    var topColorLine: UIColor = UIColor(named: "CustomBlue")!
    var bottomColorDot: UIColor = UIColor(named: "CustomRed")!
    var bottomColorLine: UIColor = UIColor(named: "CustomRed")!

    var topColorDotString: String = "Blue"
    var topColorLineString: String = "Blue"
    var bottomColorDotString: String = "Red"
    var bottomColorLineString: String = "Red"
    //private let dataSourceColor = ["Red","Orange","Yellow","Green","Blue","Purple"]

    //based on the string change the values and units
    func getTop()->String {
        return self.topGraph
    }
    func getBottom()->String{
        return self.bottomGraph
    }
    func setTop(type: String){
        self.topGraph = type
    }
    func setBottom(type: String){
        self.bottomGraph = type
    }
    func getTopColorDot()->UIColor{
        return self.topColorDot
    }
    func getTopColorLine()->UIColor{
        return self.topColorLine
    }
    func getBottomColorDot()->UIColor{
        return self.bottomColorDot
    }
    func getBottomColorLine()->UIColor{
        return self.bottomColorLine
    }
    func getTopColorDotString()->String{
        return self.topColorDotString
    }
    func getTopColorLineString()->String{
        return self.topColorLineString
    }
    func getBottomColorDotString()->String{
        return self.bottomColorDotString
    }
    func getBottomColorLineString()->String{
        return self.bottomColorLineString
    }
    func setTopColorDot(color: String){
        self.topColorDot = self.setColor(color: color)
        self.topColorDotString = color
    }

    func setColor(color: String)->UIColor{
        if(color == "Red"){
            return UIColor(named: "CustomRed")!
        }
        else if(color == "Orange"){
            return UIColor(named: "CustomOrange")!
        }
        else if(color == "Yellow"){
            return UIColor(named: "CustomYellow")!
        }
        else if(color == "Green"){
            return UIColor(named: "CustomGreen")!
        }
        else if(color == "Blue"){
            return UIColor(named: "CustomBlue")!
        }
        else if(color == "Purple"){
            return UIColor(named: "CustomPurple")!
        }
        return UIColor.cyan
    }
    func setTopColorLine(color: String){
        self.topColorLine = self.setColor(color: color)
        self.topColorLineString = color
    }
    func setBottomColorLine(color: String){
        self.bottomColorLine = self.setColor(color: color)
        self.bottomColorLineString = color
    }
    func setBottomColorDot(color: String){
        self.bottomColorDot = self.setColor(color: color)
        self.bottomColorDotString = color
    }

    var viewValues: Bool = false
    func getViewValues()->Bool{
        return self.viewValues
    }
    func setViewValues(val: Bool){
        self.viewValues = val
    }
    var sizeRadius: CGFloat = 5
    var sizeFloat: Float = 0.5
    func getSize()->CGFloat{
        return self.sizeRadius
    }
    func setSize(val: CGFloat){
        self.sizeRadius = val
    }
    func getSizeFloat()-> Float{
        return self.sizeFloat
    }
    func setSizeFloat(val: Float){
        self.sizeFloat = val
    }
    var graphSize: Double = 15.0
    var graphSizeFloat: Float = 0.5
    func getGraphSize()->Double{
        return self.graphSize
    }
    func setGraphSize(val: Double){
        if (val <= 1){
             self.graphSize = 1
        }
        else {
            self.graphSize = val
        }
    }
    func getGraphSizeFloat()-> Float{
        return self.graphSizeFloat
    }
    func setGraphSizeFloat(val: Float){
        self.graphSizeFloat = val
    }
    let bloodGlucoseUnitString = "mg/dL"
//    let getter: GetPastHealth = GetPastHealth()
    var BPTop: Bool = true
    func getBPTop()->Bool{
        return self.BPTop
    }
    func setGetBPTop(top: Bool){
        self.BPTop = top
    }
    
}
