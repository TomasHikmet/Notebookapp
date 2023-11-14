//
//  Notes.swift
//  Notebookapp
//
//  Created by Tomas Hikmet on 2023-10-17.
//

import Foundation
import FirebaseFirestoreSwift

struct Notes: Codable, Identifiable {
    var id = UUID()
    var name: String
    var category = "notes"
    var isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case isActive = "is_active"
    }
}
