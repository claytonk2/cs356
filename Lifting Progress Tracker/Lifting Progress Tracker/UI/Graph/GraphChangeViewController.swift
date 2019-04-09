////
////  GraphChangeViewController.swift
////  Havenly
////
////  Created by Benjamin Walter on 8/21/18.
////  Copyright © 2018 Benjamin Walter. All rights reserved.
////
//
//import UIKit
//
//class GraphChangeViewController: UIViewController {
//
//private let dataSource = ["Blood Glucose","Blood Pressure","Carbs","Calories","Heart Rate","Steps"]
//
//    @IBOutlet weak var TopGraphPicker: UIPickerView!
//    @IBOutlet weak var BottomGraphPicker: UIPickerView!
//    @IBOutlet weak var SettingsView: UIView!
//    @IBOutlet weak var GraphChangeButton: UIButton!
//
//    //ChangeGraphType action is on line 64
//
//    func addBottomSheetView(){
//        let bottomSheetVC = GraphChangeViewController()
//        self.addChildViewController(bottomSheetVC)
//        self.view.addSubview(bottomSheetVC.view)
//        bottomSheetVC.didMove(toParentViewController: self)
//
//        // 3- Adjust bottomSheet frame and initial position.
//        let height = view.frame.height
//        let width  = view.frame.width
//        let frame  = self.view.frame
//        bottomSheetVC.view.frame = CGRect(x: 0, y: frame.maxY, width: frame.width, height: frame.height)
//    }
//
//    override func viewDidLoad() {
//
//        SettingsView.roundCorners(cornerRadius: 20)
//        GraphChangeButton.fullroundCorners(cornerRadius: 20)
//        TopGraphPicker.selectRow(self.getInt(value: GraphSettings.settings.getTop()), inComponent: 0, animated: false)
//        BottomGraphPicker.selectRow(self.getInt(value: GraphSettings.settings.getBottom()), inComponent: 0, animated: false)
//
//    }
//
//    func getInt(value: String) -> Int{
//        if (value == "Blood Glucose"){
//            return 0
//        }
//        else if (value ==  "Blood Pressure"){
//            return 1
//        }
//        else if (value == "Carbs"){
//            return 2
//        }
//        else if (value ==  "Calories"){
//            return 3
//        }
//        else if (value == "Heart Rate"){
//            return 4
//        }
//        else if (value == "Steps"){
//            return 5
//        }
//        return 0
//    }
//
//    func prepareBackgroundView(){
//        let blurEffect = UIBlurEffect.init(style: .light)
//        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
//        let bluredView = UIVisualEffectView.init(effect: blurEffect)
//        bluredView.contentView.addSubview(visualEffect)
//
//        visualEffect.frame = UIScreen.main.bounds
//        bluredView.frame = UIScreen.main.bounds
//
//        view.insertSubview(bluredView, at: 0)
//    }
//
//    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: self.view)
//        let y = self.view.frame.minY
//        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
//        recognizer.setTranslation(.zero, in: self.view)
//    }
//
//    @IBAction func DismissGraphType(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func ChangeGraphType(_ sender: Any) {
//
//        var topData:String = ""
//        var bottomData:String = ""
//        var index: Int = 0
//        let selectedRowTop = TopGraphPicker.selectedRow(inComponent: index)
//        if let s = TopGraphPicker.delegate?.pickerView!(TopGraphPicker, titleForRow: selectedRowTop, forComponent: index) {
//            topData += s
//        }
//
//        let selectedRowBot = BottomGraphPicker.selectedRow(inComponent: index)
//        if let s = BottomGraphPicker.delegate?.pickerView!(BottomGraphPicker, titleForRow: selectedRowBot, forComponent: index) {
//            bottomData += s
//        }
//        if (topData == bottomData){
//            var alertView:UIAlertView = UIAlertView()
//            alertView.title = "Cannot Graph Same Data"
//            alertView.message = "Choose Different Data Types"
//            alertView.delegate = self
//            alertView.addButton(withTitle: "OK")
//            alertView.show()
//            return
//        }
//        if (GraphSettings.settings.getTop() != topData){
//            GraphSettings.settings.setTop(type: topData)
//        }
//        if (GraphSettings.settings.getBottom() != bottomData){
//            GraphSettings.settings.setBottom(type: bottomData)
//        }
//        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
//        dismiss(animated: true, completion: nil)
//    }
//
//    // define a variable to store initial touch position
//    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
//
//    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
//        let touchPoint = sender.location(in: self.view?.window)
//
//        if sender.state == UIGestureRecognizer.State.began {
//            initialTouchPoint = touchPoint
//        } else if sender.state == UIGestureRecognizer.State.changed {
//            if touchPoint.y - initialTouchPoint.y > 0 {
//                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
//            }
//        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
//            if touchPoint.y - initialTouchPoint.y > 100 {
//                self.dismiss(animated: true, completion: nil)
//            } else {
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//                })
//            }
//        }
//    }
//
//    /*
//     // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension GraphChangeViewController:
//UIPickerViewDelegate, UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return dataSource.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return dataSource[row]
//    }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let label = (view as? UILabel) ?? UILabel()
//
//        label.textColor = .white
//        label.textAlignment = .center
//        label.font = UIFont(name: "SanFranciscoText-Light", size: 14)
//
//        label.text = dataSource[row]
//
//        return label
//    }
//}
//
//extension UIView {
//    func roundCorners(cornerRadius: Double) {
//        self.layer.cornerRadius = CGFloat(cornerRadius)
//        self.clipsToBounds = true
//        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//    }
//
//    func fullroundCorners(cornerRadius: Double) {
//        self.layer.cornerRadius = CGFloat(cornerRadius)
//        self.clipsToBounds = true
//        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//    }
//
//}
