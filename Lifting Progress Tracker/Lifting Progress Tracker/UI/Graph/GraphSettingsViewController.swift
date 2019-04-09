//
//  GraphSettingsViewController.swift
//  Havenly
//
//  Created by Benjamin Walter on 8/21/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import UIKit

class GraphSettingsViewController: UITableViewController {

    private let dataSourceColor = ["Red","Orange","Yellow","Green","Blue","Purple"]
    
    let footerTitle = ["Maximum number of data points displayed in graph view when zoomed out"]
    
    @IBOutlet weak var DisplayValues: UISwitch!
    @IBOutlet var GraphSettingsTableView: UITableView!
    @IBOutlet weak var SIzeSlider: UISlider!
    @IBOutlet weak var SizeLabel: UILabel!
    
    @IBOutlet weak var GraphSizeSlider: UISlider!
    @IBOutlet weak var DataPoint1ColorPicker: UIPickerView!
    @IBOutlet weak var Line1ColorPicker: UIPickerView!
    @IBOutlet weak var DataPoint2ColorPicker: UIPickerView!
    @IBOutlet weak var Line2ColorPicker: UIPickerView!
    @IBOutlet weak var CloseGraphSettingsButton: UIBarButtonItem!
    
    var rotationAngle: CGFloat!
    let maxRadius: Double = 10
    let maxPointsIncluded: Double = 30
    
    @IBAction func CloseGraphSettings(_ sender: Any) {
        // here change and update the settrings
        var topDataPoint:String = ""
        var topDataLine:String = ""
        var bottomDataPoint:String = ""
        var bottomDataLine:String = ""
        var index: Int = 0
        let selectedRowTopDot = DataPoint1ColorPicker.selectedRow(inComponent: index)
        if let s = DataPoint1ColorPicker.delegate?.pickerView!(DataPoint1ColorPicker, titleForRow: selectedRowTopDot, forComponent: index) {
            topDataPoint += s
        }
        GraphSettings.settings.setTopColorDot(color: topDataPoint)
        
        let selectedRowTopLine = Line1ColorPicker.selectedRow(inComponent: index)
        if let s = Line1ColorPicker.delegate?.pickerView!(Line1ColorPicker, titleForRow: selectedRowTopLine, forComponent: index) {
            topDataLine += s
        }
        GraphSettings.settings.setTopColorLine(color: topDataLine)
        
        let selectedRowBot = DataPoint2ColorPicker.selectedRow(inComponent: index)
        if let s = DataPoint2ColorPicker.delegate?.pickerView!(DataPoint2ColorPicker, titleForRow: selectedRowBot, forComponent: index) {
            bottomDataPoint += s
        }
        GraphSettings.settings.setBottomColorLine(color: bottomDataPoint)
        
        let selectedRowBotLine = Line2ColorPicker.selectedRow(inComponent: index)
        if let s = Line2ColorPicker.delegate?.pickerView!(Line2ColorPicker, titleForRow: selectedRowBotLine, forComponent: index) {
            bottomDataLine += s
        }
        GraphSettings.settings.setBottomColorDot(color: bottomDataLine)
        GraphSettings.settings.setViewValues(val: DisplayValues.isOn)
       
        var fraction: Double = Double(SIzeSlider!.value)
        var size: CGFloat = CGFloat(fraction * maxRadius)
        GraphSettings.settings.setSize(val: size)
        GraphSettings.settings.setSizeFloat(val: SIzeSlider!.value)
        
        fraction = Double(GraphSizeSlider!.value)
        let sizeGraph:Double = Double(fraction * maxPointsIncluded)
        GraphSettings.settings.setGraphSize(val: sizeGraph)
        GraphSettings.settings.setGraphSizeFloat(val: GraphSizeSlider!.value)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        
    
        
        //this where you set the title
        // Id do something like:
       // GraphSettings.settings.getTop() + " Graph Color"
       //  GraphSettings.settings.getBottom()() + " Graph Color"
        
        
        super.viewDidLoad()
        DataPoint1ColorPicker.selectRow(self.getInt(value: GraphSettings.settings.getTopColorDotString()), inComponent: 0, animated: false)
        Line1ColorPicker.selectRow(self.getInt(value: GraphSettings.settings.getTopColorLineString()), inComponent: 0, animated: false)
        DataPoint2ColorPicker.selectRow(self.getInt(value: GraphSettings.settings.getBottomColorDotString()), inComponent: 0, animated: false)
        Line2ColorPicker.selectRow(self.getInt(value: GraphSettings.settings.getBottomColorLineString()), inComponent: 0, animated: false)
        DisplayValues.setOn(GraphSettings.settings.getViewValues(), animated: false)
        SIzeSlider.setValue(GraphSettings.settings.getSizeFloat(), animated: false)
        GraphSizeSlider.setValue(GraphSettings.settings.getGraphSizeFloat(), animated: false)
        
            SizeLabel.text = "\(Int(SIzeSlider.value))"
        
        //SIzeSlider.setValue(GraphSettings.settings.getVisibleMax(), animated: false)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }
    
    func getInt(value: String) -> Int{
        if (value == "Red"){
            return 0
        }
        else if (value == "Orange"){
            return 1
        }
        else if (value == "Yellow"){
            return 2
        }
        else if (value == "Green"){
            return 3
        }
        else if (value == "Blue"){
            return 4
        }
        else if (value == "Purple"){
            return 5
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
        
        let view = UIView()
        
        let version = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        version.font = version.font.withSize(14)
        version.text = "Maximum number of data points displayed in graph view when zoomed out"
        version.textColor = UIColor.lightGray
        version.textAlignment = .left;
        
        tableView.tableFooterView = view
        
        return view
            
        }
        else {
            
            return nil
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
        return 50
        } else {
            return 0
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        SizeLabel.text = "\(currentValue)"
    }
    
//    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
//        return "Maximum number of data points displayed when zoomed out."
//    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return 0
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

extension GraphSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSourceColor.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSourceColor[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 14)
        
        // where data is an Array of String
        label.text = dataSourceColor[row]
        
        return label
}
}
