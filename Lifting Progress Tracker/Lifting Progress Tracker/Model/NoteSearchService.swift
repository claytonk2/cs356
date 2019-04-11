//
//  NoteSearchService.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/20/18.
//  Copyright © 2018 Clayton Kingsbury. All rights reserved.
//

import Foundation
import Foundation
class NoteSearchService{
    
    func search(notes: [Note], search: String) -> [Note]{
        var containTag: [Note]  = []
        for note in notes{
            if note.getTags().contains(search){
                containTag.append(note)
            }
        }
        return containTag
    }
}
