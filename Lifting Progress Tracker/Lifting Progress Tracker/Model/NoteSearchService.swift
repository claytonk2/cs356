//
//  NoteSearchService.swift
//  Havenly
//
//  Created by Clayton kingsbury on 8/20/18.
//  Copyright © 2018 Benjamin Walter. All rights reserved.
//

import Foundation
import Foundation
class NoteSearchService{
    
    func search(notes: [INote], search: String) -> [INote]{
        var containTag: [INote]  = []
        for note in notes{
            if note.getTags().contains(search){
                containTag.append(note)
            }
        }
        return containTag
    }
}
