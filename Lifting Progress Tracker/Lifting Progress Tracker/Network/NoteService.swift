//
//  NoteService.swift
//  Lifting Progress Tracker
//
//  Created by Clayton kingsbury on 4/7/19.
//  Copyright © 2019 Clayton kingsbury. All rights reserved.
//

import Foundation
class NoteService{
    func save(note: Note){
        FirebaseDatabase.instance.AddNote(note: note)
    }
    func readAll(){
        do {
            FirebaseDatabase.instance.ReadNotes()
            //            return true
        }
        catch{
            userModel.user.addNotes(notes: [])
        }
    }
}
