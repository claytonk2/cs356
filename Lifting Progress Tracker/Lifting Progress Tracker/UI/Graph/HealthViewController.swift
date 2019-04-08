//
//  HealthViewController.swift
//  Startup_App
//
//  Created by Clayton kingsbury on 7/18/18.
//  Copyright © 2018 Clayton kingsbury. All rights reserved.
//

import UIKit
import Charts

// fix the reloading properites

class HealthViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var NoteGraph: LineChartView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var InputOpen: UIButton!
    @IBOutlet weak var DataInput: UIButton!
    @IBOutlet weak var FeedbackInput: UIButton!
    @IBOutlet weak var NoteInput: UIButton!
    @IBOutlet weak var NoteLabel: UILabel!
    @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var FeedbackLabel: UILabel!
    @IBOutlet weak var ShadowCover: UIButton!
    @IBOutlet var DataGraph: LineChartView!
    @IBOutlet weak var GraphSettingsButton: UIBarButtonItem!
    let service: WorkoutService = WorkoutService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       service.readAll()
        InputOpen.createFloatingActionButton()
        DataInput.createFloatingActionButton()
        FeedbackInput.createFloatingActionButton()
        NoteInput.createFloatingActionButton()
//        self.DataGraph.delegate = self
        noteDelegate = NoteDelegate(ins: self)
        self.NoteGraph.delegate = noteDelegate
        self.buildGraph()
//        GraphSettings.settings.setTop(type: "Blood Glucose")
//        GraphSettings.settings.setBottom(type: "Heart Rate")
        closeMenu()

    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadGraph"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.buildGraph()
//        service.readAll()
    }
    
    @objc func loadList(){
        //load data here
        DispatchQueue.main.async {
     //       self.DataGraph.initialize()
//            self.DataGraph.resetViewPortOffsets();
            self.DataGraph.clearValues();
//            self.DataGraph.clear();
//            self.DataGraph.clearAllViewportJobs()
            self.buildGraph()
        }
    }
    var noteDelegate: NoteDelegate? = nil
    func buildNoteGraph(){
        if (!userModel.user.getNotes().isEmpty && userModel.user.getNotes().count != 1){
            let (NoteAxis, NoteData) = GraphConstructor().ConstructSumarryNoteGraph(label: "", data: userModel.user.getNotes())
            self.NoteGraph.xAxis.valueFormatter = NoteAxis.valueFormatter
            self.NoteGraph.xAxis.labelPosition = .bottom
            self.NoteGraph.rightAxis.enabled = false
            self.NoteGraph.leftAxis.enabled = false
            self.NoteGraph.data = NoteData
            self.NoteGraph.legend.enabled = false
            self.NoteGraph.setVisibleXRangeMaximum(6)
            self.NoteGraph.dragEnabled = true
            self.NoteGraph.doubleTapToZoomEnabled = false//false changed this without testing
            self.NoteGraph.moveViewToAnimated(xValue: Double(userModel.user.getNotes().count), yValue: Double(0), axis: self.NoteGraph.leftAxis.axisDependency, duration: TimeInterval(2.0))
           let marker:CustomBalloon = CustomBalloon(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
            marker.minimumSize = CGSize(width: 75.0, height: 35.0)
            self.NoteGraph.marker = marker
            self.NoteGraph.drawMarkers = false
            self.NoteGraph.clipDataToContentEnabled = true
            // Make sure that only 1 x-label per index is shown
            self.NoteGraph.xAxis.granularityEnabled = true
            self.NoteGraph.xAxis.granularity = 1
            var des: Description = Description()
            des.text = "note"
            self.NoteGraph.isUserInteractionEnabled = true
            self.NoteGraph.chartDescription = des
        }
    }
    
    //let ll = ChartLimitLine(limit: 10.0, label: "Target")
   // barChartView.rightAxis.addLimitLine(ll)
    func ConstructorChoice(dataString: String)->(xAxis: XAxis, data: LineChartData){
        
            
        let (xAxis, data) = GraphConstructor().ConstructGraph(label: dataString, data: GraphData.data.getData().reversed())
        return (xAxis, data)
        
        return (XAxis(), LineChartData())
    }
//
    func buildGraph(){ // reinitialize the graph
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // do we want to animate the graph??
        self.buildNoteGraph()
        self.DateLabel.text = "Last Synced: \(DateStringConv().toStringWTimeNS(date: NSDate() as Date))"
        let graph = GraphConstructor()
//        service.readAll()
        let topString: String = GraphSettings.settings.getTop()
        let labelLine: String = topString//GraphSettings.settings.getTop() + ": " + topUnit.unitString
//        let labelBar: String = GraphSettings.settings.getBottom() + ": " + bottomUnit.unitString
//        let topString: String = topUnit.unitString
        DispatchQueue.main.async {
            if (!GraphData.data.getData().isEmpty && GraphSettings.settings.getTop() != "nul"){
//                if let test1 = (GraphData.data.getTop()[0] as! HKQuantitySample).quantity.doubleValue(for: topUnit){
//
//                }
                
                self.DataGraph.data?.notifyDataChanged()
                self.DataGraph.notifyDataSetChanged()
                self.DataGraph.invalidateIntrinsicContentSize()
                self.DataGraph.clear()
                self.DataGraph.data?.clearValues()

                self.DataGraph.invalidateIntrinsicContentSize()

                let (xAxis, data) = self.ConstructorChoice(dataString: topString)
                self.DataGraph.xAxis.resetCustomAxisMax()
                self.DataGraph.xAxis.valueFormatter = xAxis.valueFormatter /// https://stackoverflow.com/questions/38847938/how-to-render-only-chosen-axis-labels-in-ios-charts
                //self.DataGraph.xAxis.axisMaxLabels =
                self.DataGraph.xAxis.labelPosition = .bottom
                self.DataGraph.xAxis.drawLimitLinesBehindDataEnabled = true


                self.DataGraph.rightAxis.enabled = false//GraphSettings.settings.getRAxis()//false
                self.DataGraph.rightAxis.drawGridLinesEnabled = false // could be the wrong one to set
                //self.DataGraph.leftAxis.gridColor = GraphSettings.settings.getTopColorDot()
//                self.DataGraph.leftAxis.labelTextColor = GraphSettings.settings.getTopColorDot()
//                self.DataGraph.chartXMax = data.xMax
                self.DataGraph.setVisibleXRangeMaximum(data.xMax)
                self.DataGraph.data = data

                self.DataGraph.clipDataToContentEnabled = true
                // Make sure that only 1 x-label per index is shown
                self.DataGraph.xAxis.granularityEnabled = true
                self.DataGraph.xAxis.granularity = 1 //https://github.com/danielgindi/Charts/issues/2094
                self.DataGraph.setVisibleXRangeMaximum(GraphSettings.settings.getGraphSize()) //20 BEING THE HIGHEST POINT YOU WANT SHOWN, YOU CAN SCROLL ABOVE IR BELOW THAT
                //self.DataGraph.xAxis.setLabelCount(6, force: true)


                //BuildGraphView.moveViewToY(6) //8 BEING THE HIGHEST VALUE YOU WANT TO REACH AT A POINT
                self.DataGraph.dragEnabled = GraphSettings.settings.getDragEnabled()//true
                self.DataGraph.doubleTapToZoomEnabled = GraphSettings.settings.getZoom()//true//false changed this without testing
                self.DataGraph.moveViewToAnimated(xValue: Double(GraphData.data.getData().count), yValue: Double(0), axis: self.DataGraph.leftAxis.axisDependency, duration: TimeInterval(2.0))
                let marker:BPMarker = BPMarker(color: UIColor.lightGray, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
                marker.minimumSize = CGSize(width: 75.0, height: 35.0)

                self.DataGraph.marker = marker

                self.DataGraph.drawMarkers = true
                self.DataGraph.zoomOut()
                var des: Description = Description()
                des.text = "data"
                self.DataGraph.chartDescription = des
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.buildGraph()
        prepareBackgroundView()
    }

    
    @IBAction func TapToSync(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            //Make Note Graph x-axis match lower graph
            
        }
    }
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .regular)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    @IBAction func BackgroundTapped(_ sender: FloatingActionButton) {
        InputButtonTapped()
    }
    
    @IBAction func FeedbackTapped(_ sender: FloatingActionButton) {
        InputButtonTapped()
    }
    @IBAction func DataTapped(_ sender: FloatingActionButton) {
        InputButtonTapped()
    }
    @IBAction func NotesTapped(_ sender: FloatingActionButton) {
        InputButtonTapped()
    }

    @IBAction func menuTapped(_ sender: FloatingActionButton) {
        UIView.animate(withDuration: 0.2, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
                UIView.animate(withDuration: 0.2, animations: {
                    self.ShadowCover.isHidden = true
                })
            } else {
                self.menuView.transform = .identity
                UIView.animate(withDuration: 0.2, animations: {
                    self.ShadowCover.isHidden = false
                })
            }
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.menuView.transform == .identity {
                self.DataInput.transform = .identity
                self.DataLabel.transform = .identity
                self.NoteInput.transform = .identity
                self.NoteLabel.transform = .identity
                self.FeedbackInput.transform = .identity
                self.FeedbackLabel.transform = .identity
            }
        })
        
    }
    
    func closeMenu() {
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        NoteInput.transform = CGAffineTransform(translationX: 0,y: 15)
        NoteLabel.transform = CGAffineTransform(translationX: 0,y: 15)
        DataInput.transform = CGAffineTransform(translationX: 11, y: 11)
        DataLabel.transform = CGAffineTransform(translationX: 11, y: 11)
        FeedbackInput.transform = CGAffineTransform(translationX: 15, y: 0)
        FeedbackLabel.transform = CGAffineTransform(translationX: 15, y: 0)
        ShadowCover.isHidden = true
    }
    
    //Button Tapped and Menu closes
    func InputButtonTapped(){
        UIView.animate(withDuration: 0.2, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
                UIView.animate(withDuration: 0.2, animations: {
                    self.ShadowCover.isHidden = true
                })
            } else {
                
            }
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.menuView.transform == .identity {
                self.DataInput.transform = .identity
                self.DataLabel.transform = .identity
                self.NoteInput.transform = .identity
                self.NoteLabel.transform = .identity
                self.FeedbackInput.transform = .identity
                self.FeedbackLabel.transform = .identity
            }
        })
        UIView.animate(withDuration: 0.3, animations: {
            if self.InputOpen.transform == .identity {
                self.InputOpen.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
            } else {
                self.InputOpen.transform = .identity
            }
        })
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        if (!userModel.user.getNotes().isEmpty){
            var noteIndex: Int = GraphIndexToNote().calculate(date: DateStringConv().toDateFromGraph(date: GraphData.data.getDates()[dataSetIndex]) as NSDate)
            let axisDependency: YAxis.AxisDependency = self.NoteGraph.rightAxis.axisDependency
            
            self.NoteGraph.moveViewToAnimated(xValue: Double(noteIndex), yValue: Double(0), axis: axisDependency , duration: 2.0)
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
       // var desc: String = (chartView.chartDescription?.text!)!
        if (chartView.chartDescription?.text! == "note"){
            var note: Note =  userModel.user.getNotes()[Int(entry.x)] as! Note
            NoteToEdit.note.date = note.date as Date
            NoteToEdit.note.text = note.text
            NoteToEdit.note.tags = note.tags
            NoteToEdit.note.index = Int(entry.x)
            performSegue(withIdentifier: "Show Expanded Notes", sender: self)
        }
        else{
            if (!userModel.user.getNotes().isEmpty){
                var noteIndex: Int = GraphIndexToNote().calculate(date: DateStringConv().toDateFromGraph(date: GraphData.data.getDates()[Int(entry.x)]) as NSDate)
                let axisDependency: YAxis.AxisDependency = self.NoteGraph.rightAxis.axisDependency
                
                self.NoteGraph.moveViewToAnimated(xValue: Double(noteIndex), yValue: Double(0), axis: axisDependency , duration: 2.0)
               
            }
        }
    }
    
    class NoteDelegate : ChartViewDelegate {
        var instance: HealthViewController
        init(ins: HealthViewController) {
            self.instance = ins
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            var note: Note =  userModel.user.getNotes()[Int(entry.x)] as! Note
            NoteToEdit.note.date = note.date as Date
            NoteToEdit.note.text = note.text
            NoteToEdit.note.tags = note.tags
            NoteToEdit.note.index = Int(entry.x)
            self.instance.performSegue(withIdentifier: "Show Expanded Notes", sender: self.instance)
        }
    }
}
