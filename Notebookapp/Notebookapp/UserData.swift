//
//  UserData.swift
//  Notebookapp
//
//  Created by Tomas Hikmet on 2023-10-17.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable {
    @DocumentID var id: String?
    var notes: [Notes]
    var birthdate: Date
}
