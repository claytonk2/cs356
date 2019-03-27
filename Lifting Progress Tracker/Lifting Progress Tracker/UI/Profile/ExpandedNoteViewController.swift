//
//  ExpandedNoteViewController.swift
//  Havenly
//
//  Created by Benjamin Walter on 9/14/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import UIKit

class ExpandedNoteViewController: UIViewController {

    @IBOutlet weak var NoteLabel: UILabel!
    @IBOutlet weak var TagLabel: UILabel!
    @IBOutlet weak var RoundedView: UIView!
    @IBOutlet weak var DateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NoteLabel.text = NoteToEdit.note.text
        TagLabel.text = NoteToEdit.note.tags
        DateLabel.text = DateStringConv().toStringWTimeNS(date: NoteToEdit.note.date)
    }
    
    @IBAction func DismissExpandedNote(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
