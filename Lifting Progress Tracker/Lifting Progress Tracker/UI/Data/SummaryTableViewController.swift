//
//  SummaryTableViewController.swift
//  Havenly
//
//  Created by Benjamin Walter on 8/24/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import UIKit
import HealthKitUI
import Charts

class SummaryTableViewController: UITableViewController {

    @IBOutlet weak var RemindersCell: UIView!
    @IBOutlet weak var ToRemindersButton: UIButton!
    
    @IBOutlet weak var NotesCell: UIView!
    @IBOutlet weak var ToNotesButton: UIButton!
    
    @IBOutlet weak var BGGraphView: LineChartView!
    @IBOutlet weak var StepsGraphView: LineChartView!
    @IBOutlet weak var CarbsGraphView: LineChartView!
    @IBOutlet weak var CaloriesGraphView: LineChartView!
    @IBOutlet weak var HeartRateGraphView: LineChartView!
    @IBOutlet weak var BloodPressureGraphView: CombinedChartView!
    var builder: GraphConstructor = GraphConstructor()
    
    @objc func loadList(){
        //load data here
        
//        self.buildGraphs()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "summary"), object: nil)
        RemindersCell.layer.cornerRadius = 8.0
        RemindersCell.layer.masksToBounds = true
        
        NotesCell.layer.cornerRadius = 8.0
        NotesCell.layer.masksToBounds = true
        
        BGGraphView.layer.cornerRadius = 8.0
        BGGraphView.layer.masksToBounds = true
        
        StepsGraphView.layer.cornerRadius = 8.0
        StepsGraphView.layer.masksToBounds = true
        
        CarbsGraphView.layer.cornerRadius = 8.0
        CarbsGraphView.layer.masksToBounds = true
        
        CaloriesGraphView.layer.cornerRadius = 8.0
        CaloriesGraphView.layer.masksToBounds = true
        HeartRateGraphView.layer.cornerRadius = 8.0
        HeartRateGraphView.layer.masksToBounds = true
//        BloodPressureGraphView.layer.cornerRadius = 8.0
//        BloodPressureGraphView.layer.masksToBounds = true
//        DispatchQueue.main.async {
//            RecentHealthGet().get()
//        }
//        self.buildGraphs()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.buildGraphs() //might not need to comment this out / untested rn
    }
    

    // MARK: - Table view data source




    let bloodGlucoseUnitString = "mg/dL"

//    func buildGraphs(){
//        // have the label not show up
//        //
//        DispatchQueue.main.async {
//            RecentHealthGet().get()
//            let (BGAxis, BGData) = self.builder.ConstructSumarryGraph(label: "Blood Glucose Level: mg/dL", type: HKUnit(from: self.bloodGlucoseUnitString), data: SummaryGraphData.data.getBG())
//            let (HRAxis, HRData) = self.builder.ConstructSumarryGraph(label: "Heart Rate: bpm", type: HKUnit.count().unitDivided(by: HKUnit.minute()), data: SummaryGraphData.data.getHR())
//            let (CarbAxis, CarbData) = self.builder.ConstructSumarryGraph(label: "Dietary Carbohydrates: g", type: HKUnit.gram(), data: SummaryGraphData.data.getCarb())
//            let (CalAxis, CalData) = self.builder.ConstructSumarryGraph(label: "Calories Consumed: Kcals", type: HKUnit.largeCalorie(), data: SummaryGraphData.data.getCals())
//            let (StepsAxis, StepsData) = self.builder.ConstructSumarryGraph(label: "Steps: count", type: HKUnit.count(), data: SummaryGraphData.data.getSteps())
//            let (BPAxis, BPdata) = BPGraphConstructors().setChartBPLines(yValuesLineChart: SummaryGraphData.data.getDia().reversed(), yValuesBarChart: SummaryGraphData.data.getSys().reversed(), lineUnit: HKUnit.millimeterOfMercury(), barUnit: HKUnit.millimeterOfMercury(), labelLine: "", barLine: "")
//            if (!SummaryGraphData.data.getBG().isEmpty && SummaryGraphData.data.getBG().count != 1){
//                self.BGGraphView.xAxis.valueFormatter = BGAxis.valueFormatter
//                self.BGGraphView.xAxis.labelPosition = .bottom
//                self.BGGraphView.rightAxis.enabled = false
//                self.BGGraphView.data = BGData
//                self.BGGraphView.legend.enabled = false
//                self.BGGraphView.setVisibleXRangeMaximum(12)
//                self.BGGraphView.dragEnabled = true
//                self.BGGraphView.doubleTapToZoomEnabled = false//false changed this without testing
//                self.BGGraphView.moveViewToAnimated(xValue: Double(SummaryGraphData.data.getBG().count), yValue: Double(0), axis: self.BGGraphView.leftAxis.axisDependency, duration: TimeInterval(2.0))
//                let marker:BalloonMarker = BalloonMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//                marker.minimumSize = CGSize(width: 75.0, height: 35.0)
//                self.BGGraphView.marker = marker
//                self.BGGraphView.drawMarkers = true
//                self.BGGraphView.clipDataToContentEnabled = true
//                // Make sure that only 1 x-label per index is shown
//                self.BGGraphView.xAxis.granularityEnabled = true
//                self.BGGraphView.xAxis.granularity = 1
//
//               // self.BGGraphView.legend().hidden = true
//            }
//            if (!SummaryGraphData.data.getHR().isEmpty && SummaryGraphData.data.getHR().count != 1){
//                self.HeartRateGraphView.xAxis.valueFormatter = HRAxis.valueFormatter
//                self.HeartRateGraphView.xAxis.labelPosition = .bottom
//                self.HeartRateGraphView.rightAxis.enabled = false
//                self.HeartRateGraphView.data = HRData
//                self.HeartRateGraphView.legend.enabled = false
//                self.HeartRateGraphView.setVisibleXRangeMaximum(12)
//                self.HeartRateGraphView.dragEnabled = true
//                self.HeartRateGraphView.doubleTapToZoomEnabled = false//false changed this without testing
//                self.HeartRateGraphView.moveViewToAnimated(xValue: Double(SummaryGraphData.data.getHR().count), yValue: Double(0), axis: self.HeartRateGraphView.leftAxis.axisDependency, duration: TimeInterval(2.0))
//                let marker:BalloonMarker = BalloonMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//                marker.minimumSize = CGSize(width: 75.0, height: 35.0)
//                self.HeartRateGraphView.marker = marker
//                self.HeartRateGraphView.drawMarkers = true
//                self.HeartRateGraphView.clipDataToContentEnabled = true
//                // Make sure that only 1 x-label per index is shown
//                self.HeartRateGraphView.xAxis.granularityEnabled = true
//                self.HeartRateGraphView.xAxis.granularity = 1
//            }
//            if (!SummaryGraphData.data.getSteps().isEmpty && SummaryGraphData.data.getSteps().count != 1){
//                self.StepsGraphView.xAxis.valueFormatter = StepsAxis.valueFormatter
//                self.StepsGraphView.xAxis.labelPosition = .bottom
//                self.StepsGraphView.rightAxis.enabled = false
//                self.StepsGraphView.data = StepsData // index out of range error?
//                self.StepsGraphView.legend.enabled = false
//                self.StepsGraphView.setVisibleXRangeMaximum(12)
//                self.StepsGraphView.dragEnabled = true
//                self.StepsGraphView.doubleTapToZoomEnabled = false//false changed this without testing
//                self.StepsGraphView.moveViewToAnimated(xValue: Double(SummaryGraphData.data.getSteps().count), yValue: Double(0), axis: self.StepsGraphView.leftAxis.axisDependency, duration: TimeInterval(2.0))
//                let marker:BalloonMarker = BalloonMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//                marker.minimumSize = CGSize(width: 75.0, height: 35.0)
//                self.StepsGraphView.marker = marker
//                self.StepsGraphView.drawMarkers = true
//                self.StepsGraphView.clipDataToContentEnabled = true
//                // Make sure that only 1 x-label per index is shown
//                self.StepsGraphView.xAxis.granularityEnabled = true
//                self.StepsGraphView.xAxis.granularity = 1
//            }
//            if (!SummaryGraphData.data.getCarb().isEmpty && SummaryGraphData.data.getCarb().count != 1){
//                self.CarbsGraphView.xAxis.valueFormatter = CarbAxis.valueFormatter
//                self.CarbsGraphView.xAxis.labelPosition = .bottom
//                self.CarbsGraphView.rightAxis.enabled = false
//                self.CarbsGraphView.data = CarbData
//                self.CarbsGraphView.legend.enabled = false
//                self.CarbsGraphView.setVisibleXRangeMaximum(6)
//                self.CarbsGraphView.dragEnabled = true
//                self.CarbsGraphView.doubleTapToZoomEnabled = false//false changed this without testing
//                self.CarbsGraphView.moveViewToAnimated(xValue: Double(SummaryGraphData.data.getCarb().count), yValue: Double(0), axis: self.CarbsGraphView.leftAxis.axisDependency, duration: TimeInterval(2.0))
//                let marker:BalloonMarker = BalloonMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//                marker.minimumSize = CGSize(width: 75.0, height: 35.0)
//                self.CarbsGraphView.marker = marker
//                self.CarbsGraphView.drawMarkers = true
//                self.CarbsGraphView.clipDataToContentEnabled = true
//                // Make sure that only 1 x-label per index is shown
//                self.CarbsGraphView.xAxis.granularityEnabled = true
//                self.CarbsGraphView.xAxis.granularity = 1
//            }
//            if (!SummaryGraphData.data.getCals().isEmpty && SummaryGraphData.data.getCals().count != 1){
//                self.CaloriesGraphView.xAxis.valueFormatter = CalAxis.valueFormatter
//                self.CaloriesGraphView.xAxis.labelPosition = .bottom
//                self.CaloriesGraphView.rightAxis.enabled = false
//                self.CaloriesGraphView.data = CalData
//                self.CaloriesGraphView.legend.enabled = false
//                self.CaloriesGraphView.setVisibleXRangeMaximum(6)
//                self.CaloriesGraphView.dragEnabled = true
//                self.CaloriesGraphView.doubleTapToZoomEnabled = false//false changed this without testing
//                self.CaloriesGraphView.moveViewToAnimated(xValue: Double(SummaryGraphData.data.getCals().count), yValue: Double(0), axis: self.CaloriesGraphView.leftAxis.axisDependency, duration: TimeInterval(2.0))
//                let marker:BalloonMarker = BalloonMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//                marker.minimumSize = CGSize(width: 75.0, height: 35.0)
//                self.CarbsGraphView.marker = marker
//                self.CarbsGraphView.drawMarkers = true
//                self.CaloriesGraphView.clipDataToContentEnabled = true
//                // Make sure that only 1 x-label per index is shown
//                self.CaloriesGraphView.xAxis.granularityEnabled = true
//                self.CaloriesGraphView.xAxis.granularity = 1
//
//            }
//            if (!SummaryGraphData.data.getSys().isEmpty && SummaryGraphData.data.getSys().count != 1){
////                self.BloodPressureGraphView.xAxis.valueFormatter = BPAxis.valueFormatter
////                self.BloodPressureGraphView.xAxis.labelPosition = .bottom
////                self.BloodPressureGraphView.rightAxis.enabled = false
////                self.BloodPressureGraphView.data = BPData
////                self.BloodPressureGraphView.legend.enabled = false
////                self.BloodPressureGraphView.setVisibleXRangeMaximum(6)
////                self.BloodPressureGraphView.dragEnabled = true
////                self.BloodPressureGraphView.doubleTapToZoomEnabled = true//false changed this without testing
////                self.BloodPressureGraphView.moveViewToAnimated(xValue: Double(SummaryGraphData.data.getSys().count), yValue: Double(0), axis: self.BloodPressureGraphView.leftAxis.axisDependency, duration: TimeInterval(2.0))
////                let marker:BalloonMarker = BalloonMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
////                marker.minimumSize = CGSize(width: 75.0, height: 35.0)
////                self.BloodPressureGraphView.marker = marker
////                self.BloodPressureGraphView.drawMarkers = true
////                self.BloodPressureGraphView.clipDataToContentEnabled = true
////                // Make sure that only 1 x-label per index is shown
////                self.BloodPressureGraphView.xAxis.granularityEnabled = true
////                self.BloodPressureGraphView.xAxis.granularity = 1
//
//                self.BloodPressureGraphView.xAxis.valueFormatter = BPAxis.valueFormatter /// https://stackoverflow.com/questions/38847938/how-to-render-only-chosen-axis-labels-in-ios-charts
//                self.BloodPressureGraphView.xAxis.labelPosition = .bottom
//                self.BloodPressureGraphView.xAxis.drawLimitLinesBehindDataEnabled = true
//
//
//                self.BloodPressureGraphView.rightAxis.enabled = false// GraphSettings.settings.getRAxis()//false
//                self.BloodPressureGraphView.data = BPdata
//                self.BloodPressureGraphView.leftAxis.axisMinimum = 40
//
//                self.BloodPressureGraphView.rightAxis.axisMinimum = 40
//                self.BloodPressureGraphView.clipDataToContentEnabled = true
//                // Make sure that only 1 x-label per index is shown
//                self.BloodPressureGraphView.xAxis.granularityEnabled = true
//                self.BloodPressureGraphView.xAxis.granularity = 1 //https://github.com/danielgindi/Charts/issues/2094
//                self.BloodPressureGraphView.setVisibleXRangeMaximum(6) //20 BEING THE HIGHEST POINT YOU WANT SHOWN, YOU CAN SCROLL ABOVE IR BELOW THAT
//                //self.DataGraph.xAxis.setLabelCount(6, force: true)
//
//                self.BloodPressureGraphView.legend.enabled = false
//                //BuildGraphView.moveViewToY(6) //8 BEING THE HIGHEST VALUE YOU WANT TO REACH AT A POINT
//                self.BloodPressureGraphView.dragEnabled = true
//                self.BloodPressureGraphView.doubleTapToZoomEnabled = false//false changed this without testing
//                self.BloodPressureGraphView.moveViewToAnimated(xValue: Double(SummaryGraphData.data.getDia().count + GraphData.data.getBottom().count), yValue: Double(0), axis: self.BloodPressureGraphView.leftAxis.axisDependency, duration: TimeInterval(2.0))
//                let marker:BPMarker = BPMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
//                marker.minimumSize = CGSize(width: 75.0, height: 35.0)
//
//                self.BloodPressureGraphView.marker = marker
//                self.BloodPressureGraphView.drawMarkers = true
//
//            }
//        }
//    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
