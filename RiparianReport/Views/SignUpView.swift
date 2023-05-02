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
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("MatteBlack").ignoresSafeArea()
                VStack{
                    LogoView()
                    Group {
                        ZStack{
                            TextField("Email", text: $email)
                                .frame(width: 150, height: 20)
                                .foregroundColor(Color.accentColor)
                                .padding(.bottom, 40)
                                .background {
                                    Capsule()
                                        .strokeBorder(Color("Sand"), lineWidth: 5)
                                        .frame(width: 250, height: 50)
                                        .padding(.bottom, 40)
                                        
                                    
                                }
                            if (email.isEmpty) {
                                Text("Email").foregroundColor((Color("Sand")))
                                    .padding(.bottom, 40)
                                    .offset(x: -54)
                            }
                        }
                        ZStack {
                            SecureField("Password", text: $password)
                                .frame(width: 150, height: 20)
                                .foregroundColor(Color.accentColor)
                                .padding(.bottom, 40)
                                .background {
                                    Capsule()
                                        .strokeBorder(Color("Sand"), lineWidth: 5)
                                        .frame(width: 250, height: 50)
                                        .padding(.bottom, 40)
                                     
                                }
                            if (password.isEmpty) {
                                Text("Password").foregroundColor((Color("Sand")))
                                    .padding(.bottom, 40)
                                    .offset(x: -39)
                            }
                        }
                    }
                    Group {
                        Button {
                            register()
                            print(email, password)
                        } label: {
                            ZStack {
                                Capsule()
                                    .fill()
                                    .frame(width: 250, height: 50)
                                Text("Login").font(.custom("Poppins-Medium", size: 32)).foregroundColor(Color("MatteBlack"))
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
                
        }

    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                appState.setLoggedIn()
                appState.saveUserName(userName: email)
            }
            print("Signup", "email", String(email), "password", String(password))
            
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
