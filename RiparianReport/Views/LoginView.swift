//
//  LoginView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/15/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Login").foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 48))
                Spacer()
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                Button {
                    login()
                } label: {
                    Text("Login").foregroundColor(Color.accentColor).font(.custom("Poppins-Bold", size: 32))
                    
                }
                Spacer()
                Button {
                    appState.loggedIn = true
                } label: {
                    Text("HACKEDDD")
                }
                
                Spacer()
                Text("Don't have an account?").foregroundColor(Color("Sand"))
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign up").font(.custom("Poppins-Bold", size: 32)).foregroundColor(Color.accentColor)
                    }
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
    //static var previews: some View {
        //LoginView(path: NavigationPath)
    //}
//}
