//
//  LoginView.swift
//  RiparianReport
//
//  Created by TLC Loaner on 4/15/23.
//
import SwiftUI
import Firebase
import FirebaseAuth


struct LogoView: View {
    var body: some View {
        ZStack {
            Group {
                Image("leaf").resizable().scaledToFit()
                Text("Welcome").foregroundColor(Color("MatteBlack")).font(.custom("Poppins-Bold", size: 48))
            }
        }
    }
}







struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var appState: AppState
    var body: some View {
        NavigationStack{
            ZStack {
                Color("MatteBlack").ignoresSafeArea()
                VStack{
                    LogoView()
                    Group {
                        TextField("Email", text: $email)
                            .frame(width: 150, height: 20)
                            .foregroundColor(Color.accentColor)
                            .padding(.bottom, 40)
                            .background {
                                Capsule()
                                //.strokeBorder(Color("Sand"), lineWidth: 5)
                                    .frame(width: 250, height: 50)
                                    .padding(.bottom, 40)
                                    .foregroundColor(Color("Sand"))
                                
                            }
                        TextField("Password", text: $password)
                            .frame(width: 150, height: 20)
                            .foregroundColor(Color.accentColor)
                            .padding(.bottom, 40)
                            .background {
                                Capsule()
                                //.strokeBorder(Color("Sand"), lineWidth: 5)
                                    .frame(width: 250, height: 50)
                                    .padding(.bottom, 40)
                                    .foregroundColor(Color("Sand"))
                            }
                        Button {
                            password = "yur"
                        } label: {
                            Text("yurr")
                        }

                    }
                    Group {
                        Button {
                            login()
                            print(email, password)
                        } label: {
                            ZStack {
                                Capsule()
                                    .fill()
                                    .frame(width: 250, height: 50)
                                Text("Login").font(.custom("Poppins-Medium", size: 32)).foregroundColor(Color("Sand"))
                            }
                        }
                        
                        Spacer()
                        Text("Don't have an account?").foregroundColor(Color("Sand"))
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Sign up").font(.custom("Poppins-Bold", size: 18)).foregroundColor(Color.accentColor)
                        }
                    }
                }
                }
                
            }
        }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                appState.setLoggedIn()
            }
            print("Login", "email", email, "password", password)
        }
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
