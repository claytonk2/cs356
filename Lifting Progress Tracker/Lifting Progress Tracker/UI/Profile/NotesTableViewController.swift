////
////  NotesTableViewController.swift
////  Havenly
////
////  Created by Benjamin Walter on 8/9/18.
////  Copyright © 2018 Benjamin Walter. All rights reserved.

import UIKit

class NotesTableViewController: UITableViewController, UISearchBarDelegate { // Clayton deleted the DataSentDelegate from here
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var DoneButton: UIBarButtonItem!
    @IBOutlet weak var IndividualNote: UITableView!
    var currentNotes: [INote] = []
    
    @IBAction func CloseNotes(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = deleteAction(at: indexPath)
        
        let edit = editAction(at: indexPath)
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [edit])//, delete]) // fix these for the notes
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
//    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
//            self.currentNotes.remove(at: indexPath.row)
//            var temp: Note = userModel.user.notes[indexPath.row] as! Note
//            userModel.user.notes.remove(at: indexPath.row)
//            UpdateNotes().delete(note: temp)
//            //            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//
//            print("index path of delete: \(indexPath)")
//            completion(true)
//        }
//        return action
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        IndividualNote.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        currentNotes = userModel.user.getNotes()// add in the array and edit it when searched
        IndividualNote.reloadData()
    }
    
    private func setUpSearchBar() {
        SearchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadNote"), object: nil)
        
        IndividualNote.dataSource = self
        IndividualNote.delegate = self
        currentNotes = userModel.user.getNotes()
        IndividualNote.reloadData()
        setUpSearchBar()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func loadList(){
        //load data here
        self.IndividualNote.reloadData()
    }
    
    func userDidEnterData(notesObj: INote){
        userModel.user.addNote(note: notesObj)
        //currentNotes = userModel.user.getNotes()
        self.IndividualNote.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//currentNotes.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        //cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]


        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesCell

        //get address object from array which you can assign to cell
        let notesObj = currentNotes[indexPath.row]
        //assign data from array
        cell.updateUI(notesObj: notesObj)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String){
        if( textSearched != ""){
            currentNotes = NoteSearchService().search(notes: userModel.user.getNotes(), search: textSearched)
        }
        else{
            currentNotes = userModel.user.getNotes()
        }
        self.IndividualNote.reloadData()
    }
    
    func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            
            NoteToEdit.note.text = userModel.user.getNotes()[indexPath.row].getText()
            NoteToEdit.note.date = userModel.user.getNotes()[indexPath.row].getDate() as! Date
            NoteToEdit.note.tags = userModel.user.getNotes()[indexPath.row].getTags()
            NoteToEdit.note.index = indexPath.row
            print("index path of edit: \(indexPath)")
            self.performSegue(withIdentifier: "EditRemindersSegue", sender: self)
            completion(true)
        }
        return action
    }
}
