//
//  ListofNotesView.swift
//  Notebookapp
//
//  Created by Tomas Hikmet on 2023-10-17.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct ListofNotesView: View {
    
    @ObservedObject var db: DbConnection
    
    var body: some View {
        NavigationStack {
        VStack {
        HStack{
        Text("Notes").font(.title).bold().padding()
          Button(action: {
                        do {
                            try Auth.auth().signOut()
                        
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }) {
                        Text("Sign Out")
                            
                    }

                        }
                    }

                }
                
                
                Spacer()
                
                if let userData = db.currentUserData {
                    
                    if userData.notes.count < 1 {
                        Text("No Notes yet!")
                    } else {
                        List() {
                            ForEach(userData.notes) { Notes in
                                Text(Notes.name)
                            }
                        }
                    }
                    
                    
                } else {
                    
                    Text("Unexpected error, please contact your administrator.")
                    
                }
                
                NavigationLink(destination: AddNotesView(db: db), label: {
                Text("Add Note").bold().padding().foregroundColor(.white).background(.blue).cornerRadius(9)
                })
                
                Spacer()
            }
                    }

                struct ListofNotesView_Previews: PreviewProvider {
                    static var previews: some View {
                        ListofNotesView(db: DbConnection())
                    }
                }
