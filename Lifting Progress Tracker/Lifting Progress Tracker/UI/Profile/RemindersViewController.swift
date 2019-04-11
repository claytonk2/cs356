//
//  RemindersViewController.swift
//  Havenly
//
//  Created by Clayton Kingsbury on 8/2/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    struct cellData {
        let list: String
        let dateList: String
    }

    var list = [""]
    var dateList = [""]

    //var data = [cellData]()

    @IBOutlet weak var RemindersList: UITableView!

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//currentNotes.count
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)

        let edit = editAction(at: indexPath)

        let swipeActionConfig = UISwipeActionsConfiguration(actions: [edit, delete])
        //Add edit into delete: [edit, delete]
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }

    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
//            self.dateList.remove(at: indexPath.row)
//            self.list.remove(at: indexPath.row)
            var temp: Note = userModel.user.reminders[indexPath.row]
            userModel.user.reminders.remove(at: indexPath.row)
//            UpdateReminder().delete(rem: temp)
            //NotificationCenter.removePendingNotificationsRequests(withIdentifiers:  ["localNotification"])

//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            print("index path of delete: \(indexPath)")
            completion(true)
        }

        return action
    }
//
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModel.user.getReminders().count //data.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemindersCustomCell", for: indexPath) as! RemindersCustomCell
        //cell.TitleLabel.text = list[indexPath.row]
        //cell.TitleLabel.text = cell.updateUI(reminder: Note.getText()[indexPath.row])

        //cell.dateLabel.text = dateList[indexPath.row]
        //cell.dateLabel.text = cell.updateUI(reminder: Note.getDate()[indexPath.row])

        cell.updateUI(reminder: userModel.user.getReminders()[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }

    @IBAction func DismissReminders(_ sender: Any) {
    navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        RemindersList.dataSource = self
        RemindersList.delegate = self
        //data = [cellData.init(list: "", dateList: "")]
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadRem"), object: nil)
        //self.RemindersList.register(RemindersCustomCell.self, forCellReuseIdentifier: "RemindersCustomCell")
        // Do any additional setup after loading the view.

        RemindersList.reloadData()

//        NotificationCenter.default.addObserver(self, selector: #selector(handleInputClosing), name: .saveDateTime, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        RemindersList.reloadData()
    }

    @objc func handleInputClosing(notification: Notification) {
//        let viewController = notification.object as! ReminderInputViewController
    }

    @objc func loadList(){
        //load data here
        self.RemindersList.reloadData()
    }

    func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in



            ReminderToEdit.reminder.text = userModel.user.getReminders()[indexPath.row].getText()
            ReminderToEdit.reminder.date = userModel.user.getReminders()[indexPath.row].getDate() as! Date
            ReminderToEdit.reminder.index = indexPath.row

            print("index path of edit: \(indexPath)")
            self.performSegue(withIdentifier: "EditRemindersSegue", sender: self)
            completion(true)
        }
        return action
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
