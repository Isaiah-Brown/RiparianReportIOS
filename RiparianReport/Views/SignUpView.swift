//
//  SignUpView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/15/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Sign up").foregroundColor(Color.accentColor)
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                Spacer()
                Button {
                    register()
                    print(email, password)
                } label: {
                    Text("Sign up").font(.custom("Poppins-Bold", size: 32)).foregroundColor(Color.accentColor)
                }
                
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            print("Signup", "email", email, "password", password)
            
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
