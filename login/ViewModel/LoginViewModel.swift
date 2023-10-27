//
//  LoginViewModel.swift
//  login
//
//  Created by Caroline Klakegg on 25/10/2023.
//

import Foundation
import SwiftUI
import Firebase


class LoginViewModel: ObservableObject {
    
    @State var email = ""
    @State var password = ""
    
    
    public func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                
            }
            
        }
    }
    
    
    public func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
