//
//  ContentView.swift
//  Notebookapp
//
//  Created by Tomas Hikmet on 2023-10-13.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    @StateObject var db = DbConnection()
    
    @State var notearray: [Notes] = []
    
  @State var showSplash = true
    var body: some View {
        
        if showSplash {
            SplashScreenView()
        } else {
            if db.currentUser != nil {
                NavigationStack {
                    ListofNotesView(db: db)
                }
            } else {
                NavigationStack {
                    LoginView(db: db)
                }
            }
            
        }
    }
    
    struct SplashScreenView:View {
        @State var showsplashscreen=true
        var body: some View {
            ZStack{
            if showsplashscreen{
            SplashScreenImage().onAppear(){
            DispatchQueue.main.asyncAfter(deadline:.now()+1){
            withAnimation{
            showsplashscreen=false
            }
            }
            }
            } else{
            }
            }
            }
        
        struct SplashScreenImage:View {
            var body: some View {
                Image("book").resizable().aspectRatio(contentMode:.fit)
                
            }
        }
        struct ContentView_Previews:PreviewProvider {
            static var previews: some View {
                ContentView().previewDevice("iphone SE 3rd generation")
            }
        }
    }
}
