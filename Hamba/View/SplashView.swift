//
//  SplashView.swift
//  Hamba
//
//  Created by Thomas Frey on 15.01.23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
            } else {
                Image(systemName: "tree")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                Text("Hamba")
                    .padding()
                    .font(.system(size: 50, weight: .heavy, design: .serif))
           
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
