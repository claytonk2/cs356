////
////  SummaryViewController.swift
////  Startup_App
////
////  Created by Benjamin Walter on 7/24/18.
////  Copyright © 2018 Clayton kingsbury. All rights reserved.
////
//
//import UIKit
//import HealthKitUI
//import Charts
//
//class SummaryViewController: UIViewController {
//
//    @IBOutlet weak var menuView: UIView!
//    @IBOutlet weak var InputOpen: UIButton!
//    @IBOutlet weak var NoteInput: UIButton!
//    @IBOutlet weak var DataInput: UIButton!
//    @IBOutlet weak var FeedbackInput: UIButton!
//    @IBOutlet weak var NoteLabel: UILabel!
//    @IBOutlet weak var DataLabel: UILabel!
//    @IBOutlet weak var FeedbackLabel: UILabel!
//    @IBOutlet weak var ShadowCover: UIButton!
//    @IBOutlet weak var BuildGraphView: LineChartView! // here is where I am going to build the graphs.
//    @IBOutlet weak var NotesButton: UIButton!
//
//
//    @IBAction func NotesPressed(_ sender: Any) {
//
//    }
//
//    @IBAction func unwindToSummary(segue:UIStoryboardSegue) { }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let graph = GraphConstructor()
//        let bloodGlucoseUnitString = "mg/dL"
//        let (valueArray, timeArray) = graph.readData(data: userModel.user.getBloodGlucose() as! [HKSample], type: HKUnit(from: bloodGlucoseUnitString ))
//        let data: LineChartData = graph.setChart(dataPoints: timeArray, values: valueArray, label: "Blood Glucose Level: mg/dL")
//
//        let xAxis=XAxis()
//        let chartFormmater: ChartFormatter = ChartFormatter(labels: timeArray)
//
//        for i in 0..<timeArray.count {
//            chartFormmater.stringForValue(Double(i), axis: xAxis)
//        }
//
//        xAxis.valueFormatter = chartFormmater
//        xAxis.wordWrapEnabled = true
//        BuildGraphView.xAxis.valueFormatter = xAxis.valueFormatter /// https://stackoverflow.com/questions/38847938/how-to-render-only-chosen-axis-labels-in-ios-charts
//        BuildGraphView.xAxis.labelPosition = .bottom
//        BuildGraphView.rightAxis.enabled = false
//        BuildGraphView.data = data
//        BuildGraphView.setVisibleXRangeMaximum(6) //20 BEING THE HIGHEST POINT YOU WANT SHOWN, YOU CAN SCROLL ABOVE IR BELOW THAT
//        //BuildGraphView.moveViewToY(6) //8 BEING THE HIGHEST VALUE YOU WANT TO REACH AT A POINT
//        BuildGraphView.dragEnabled = true
//        BuildGraphView.doubleTapToZoomEnabled = false
//        /*
// let limitLine = ChartLimitLine(limit: xValue, label:
// labelForThisLine)
// limitLine.lineWidth = 0.5
// limitLine.lineColor = .black
// limitLine.valueTextColor = .black
// chartView.xAxis.addLimitLine(limitLine)
//
// */
//
//        InputOpen.createFloatingActionButton()
//        DataInput.createFloatingActionButton()
//        FeedbackInput.createFloatingActionButton()
//        NoteInput.createFloatingActionButton()
//
//        closeMenu()
//    }
//
//    @IBAction func BackgroundTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//    @IBAction func FeedbackTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//    @IBAction func DataTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//    @IBAction func NotesTapped(_ sender: FloatingActionButton) {
//        InputButtonTapped()
//    }
//
//    @IBAction func menuTapped(_ sender: FloatingActionButton) {
//        UIView.animate(withDuration: 0.2, animations: {
//            if self.menuView.transform == .identity {
//                self.closeMenu()
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.ShadowCover.isHidden = true
//                })
//            } else {
//                self.menuView.transform = .identity
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.ShadowCover.isHidden = false
//                })
//            }
//        })
//        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
//            if self.menuView.transform == .identity {
//                self.DataInput.transform = .identity
//                self.DataLabel.transform = .identity
//                self.NoteInput.transform = .identity
//                self.NoteLabel.transform = .identity
//                self.FeedbackInput.transform = .identity
//                self.FeedbackLabel.transform = .identity
//            }
//        })
//
//    }
//
//    func closeMenu() {
//        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        NoteInput.transform = CGAffineTransform(translationX: 0,y: 15)
//        NoteLabel.transform = CGAffineTransform(translationX: 0,y: 15)
//        DataInput.transform = CGAffineTransform(translationX: 11, y: 11)
//        DataLabel.transform = CGAffineTransform(translationX: 11, y: 11)
//        FeedbackInput.transform = CGAffineTransform(translationX: 15, y: 0)
//        FeedbackLabel.transform = CGAffineTransform(translationX: 15, y: 0)
//        ShadowCover.isHidden = true
//    }
//
//    //Button Tapped and Menu closes
//    func InputButtonTapped(){
//        UIView.animate(withDuration: 0.2, animations: {
//            if self.menuView.transform == .identity {
//                self.closeMenu()
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.ShadowCover.isHidden = true
//                })
//            } else {
//
//            }
//        })
//        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
//            if self.menuView.transform == .identity {
//                self.DataInput.transform = .identity
//                self.DataLabel.transform = .identity
//                self.NoteInput.transform = .identity
//                self.NoteLabel.transform = .identity
//                self.FeedbackInput.transform = .identity
//                self.FeedbackLabel.transform = .identity
//            }
//        })
//        UIView.animate(withDuration: 0.3, animations: {
//            if self.InputOpen.transform == .identity {
//                self.InputOpen.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
//            } else {
//                self.InputOpen.transform = .identity
//            }
//        })
//
//    }
//
//}
