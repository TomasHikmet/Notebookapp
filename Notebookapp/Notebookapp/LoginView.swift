//
//  LoginView.swift
//  Notebookapp
//  Created by Tomas Hikmet on 2023-10-17.



import Foundation
import SwiftUI



struct LoginView: View {
    
    @ObservedObject var db: DbConnection
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .center, spacing: 30) {
            
            Text("Welcome to Notebook!")
                .bold()
                .font(.system(size: 24)).padding(.bottom, geometry.size.height * 0.02)
                
                VStack(alignment: .leading) {
                    Text("Enter your credentials").font(.title3).bold()
                    
                    TextField("Email address", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password).textFieldStyle(.roundedBorder)
                    
                }.padding()
                
                Button(action: {
                    
                    if !email.isEmpty && !password.isEmpty {
                        let isSuccess = db.LoginUser (email: email, password: password)
                    }
                    
                }, label: {
                    Text("Log in")
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(9)
                })
                
                NavigationLink(destination: RegisterView(db: db), label: {
                    Text("Register account").bold().padding().foregroundColor(.black)
                })
            
            
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(db: DbConnection())
    }
}
