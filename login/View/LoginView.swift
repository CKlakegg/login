//
//  LoginView.swift
//  login
//
//  Created by Caroline Klakegg on 27/10/2023.
//

import Foundation
import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    
    var body: some View {
        if userIsLoggedIn{
          // go to next screen
            HomeView ()
        } else{
            
            content
        }
    }
    
    
    
//MARK: Viewbuilder for design
    
    @ViewBuilder
    private var content: some View {
        ZStack{
            Color.black
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(.mint)
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20){
                welcomeText
                emailTextField
                passwordTextField
                signInButton
            }
            .frame(width: 350)
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
   //Text display on login screen
    @ViewBuilder
    private var welcomeText: some View {
        
        Text("Welcome")
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .offset(x: -100, y:-100)
    }
    
    //Textfield for email input
    @ViewBuilder
    private var emailTextField: some View {
        
        TextField("Email", text: $email)
                 .foregroundColor(.white)
                 .textFieldStyle(.plain)
                 .placeholder(when: email.isEmpty){
                     Text("Email")
                         .foregroundColor(.white)
                         .bold()
                 }
        Rectangle()
            .frame(width: 350, height: 1)
            .foregroundColor(.white)

    }
    
    //Textfield for password input
    @ViewBuilder
    private var passwordTextField: some View {
        
        TextField("Password", text: $password)
                 .foregroundColor(.white)
                 .textFieldStyle(.plain)
                 .placeholder(when: password.isEmpty){
                     Text("Password")
                         .foregroundColor(.white)
                         .bold()
                 }
        Rectangle()
            .frame(width: 350, height: 1)
            .foregroundColor(.white)
    }
    
    //Sign in button
    @ViewBuilder
    private var signInButton: some View {
        Button{
          //sign up action
            register()
        } label: {
            Text ("Sign up")
                .bold()
                .frame(width: 200, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.linearGradient(colors: [.mint, .yellow], startPoint: .top, endPoint: .bottomTrailing))
                )
                .foregroundColor(.white)
        }
        .padding(.top)
        .offset(y: 100)
        
        Button{
          //login
            login()
        } label: {
            Text ("Already have an account? Login")
                .bold()
                .foregroundColor(.white)
        }
        .padding(.top)
        .offset(y: 110)
        
    }
    
     func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            
        }
    }
    
     func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }

}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
       LoginView()
    }
}



extension View {
    func placeholder <Content: View> (
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment ){
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


