//
//  SplashScreenView.swift
//  login
//
//  Created by Caroline Klakegg on 25/10/2023.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    
    var body: some View {
         
        if isActive {
            ContentView()
        } else{
            
            VStack{
                
                Text("Hei")
                    .foregroundColor(.red)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration: 1.5)) {
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6 ) {
                    self.isActive = true
                }
            }
        }
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
    }
}
