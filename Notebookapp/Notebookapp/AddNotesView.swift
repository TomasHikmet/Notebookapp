//
//  AddNotesView.swift
//  Notebookapp
//
//  Created by Tomas Hikmet on 2023-10-17.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct AddNotesView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var db: DbConnection
    
    @State var Notes = ""
    
    var body: some View {
        VStack {
            Text("Lägg till en Note").padding()
            
            TextField("Ange Note",text:$Notes).textFieldStyle(.roundedBorder).padding()
            
            Button(action: {
                
                if !Notes.isEmpty {
                    
                    let newNotes = Notebookapp.Notes (name: Notes, isActive: true)

                    db.addnotesToDb (notes: newNotes)
                    dismiss()
                }
                
            }, label: {
                Text("Skapa").bold()
            })
        }
        .padding()
    }
    
}

struct AddNotesView_Previews: PreviewProvider {
    static var previews: some View {
        AddNotesView(db: DbConnection())
    }
}
