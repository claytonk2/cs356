//
//  WorkoutTableViewController.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/8/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    
    @IBOutlet var workouts: UITableView!
    @IBOutlet weak var SearchWorkouts: UISearchBar!
    
    
    @IBAction func CloseWorkouts(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    var currentWorkouts: [Workout] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        workouts.dataSource = self
        workouts.delegate = self
        currentWorkouts = userModel.user.getWorkouts()
        workouts.reloadData()
        setUpSearchBar()
        WorkoutService().readAll() // todo idk if I need this
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadW"), object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func setUpSearchBar() {
        SearchWorkouts.delegate = self
    }
    
    @objc func loadList(){
        //load data here
        currentWorkouts = userModel.user.getWorkouts()
        self.workouts.reloadData()
    }

    
    func userDidEnterData(workout: Workout){
        userModel.user.addWorkout(Workout: workout)
        //currentNotes = userModel.user.getNotes()
        self.workouts.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//currentNotes.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentWorkouts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        //cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as! WorkoutTableViewCell
        
        //get address object from array which you can assign to cell
        let work = currentWorkouts[indexPath.row]
        //assign data from array
        cell.updateUI(workout: work)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String){
        if( textSearched != ""){
            currentWorkouts = WorkoutSearchService().search(workouts: userModel.user.getWorkouts(), search: textSearched)
        }
        else{
            currentWorkouts = userModel.user.getWorkouts()
        }
        self.workouts.reloadData()
    }
    
//    func editAction(at indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
//
//            NoteToEdit.note.text = userModel.user.getNotes()[indexPath.row].getText()
//            NoteToEdit.note.date = userModel.user.getNotes()[indexPath.row].getDate() as! Date
//            NoteToEdit.note.tags = userModel.user.getNotes()[indexPath.row].getTags()
//            NoteToEdit.note.index = indexPath.row
//            print("index path of edit: \(indexPath)")
//            self.performSegue(withIdentifier: "EditRemindersSegue", sender: self)
//            completion(true)
//        }
//        return action
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
