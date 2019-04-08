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

    @IBOutlet var SummaryTable: UITableView!
   
    
//    @IBOutlet weak var Workouts: UITableViewCell!
//    @IBOutlet weak var WorkoutTable: UITableViewSection!
//    var workouts: [Workout] = []
    
    let service: WorkoutService = WorkoutService()
    
    var builder: GraphConstructor = GraphConstructor()
    
    @objc func loadList(){
        SummaryTable.reloadData()
        
    }
    @IBOutlet weak var InputOpen: UIButton!
    @IBOutlet weak var DataInput: UIButton!
    @IBOutlet weak var NoteInput: UIButton!
    
    @IBOutlet weak var FeedbackInput: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "summary"), object: nil)
        SummaryTable.delegate = self
        SummaryTable.dataSource = self
        
        service.readAll()//workouts =
        NoteService().readAll()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadWorkout"), object: nil)
//        InputOpen.createFloatingActionButton()
//        DataInput.createFloatingActionButton()
//        FeedbackInput.createFloatingActionButton()
//        NoteInput.createFloatingActionButton()
        
       
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
        SummaryTable.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        service.readAll() // workouts =
//        self.buildGraphs() //might not need to comment this out / untested rn
    }
    

    // MARK: - Table view data source

    
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
    
    //FAB Menu Stuff
  
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
//    //
//    @IBOutlet weak var menuView: UIView!
//    @IBOutlet weak var DataLabel: UILabel!
//    @IBOutlet weak var ShadowCover: UIButton!
//
//    @IBOutlet weak var NoteLabel: UILabel!
//
//
//
//    @IBOutlet weak var FeedbackLabel: UILabel!
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
//
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
//    }
    
    
    
    
//    change the table to be dynamic, fix the top cells and make it work
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        //cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell" , for: indexPath) as! SummaryTableViewCell
            return cell
        }
//        tableView.register(AnyClass?, forCellReuseIdentifier: <#T##String#>)
        let nib = UINib(nibName: "WorkoutCell", bundle: nil)
//        self.tableView.register(WorkoutCell.self, forCellReuseIdentifier: "WorkoutTableViewCell")//register(WorkoutTableViewCell(), forCellWithReuseIdentifier: "WorkoutTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell" , for: indexPath) as! WorkoutTableViewCell

        //get address object from array which you can assign to cell
        let notesObj = userModel.user.getWorkouts()[indexPath.row - 1]
        //assign data from array
        cell.updateUI(workout: notesObj)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 150
        }
        return 76
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userModel.user.getWorkouts().count + 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//currentNotes.count
    }
}
