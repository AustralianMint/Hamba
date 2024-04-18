//
//  creditScreen.swift
//  Hamba
//
//  Created by Péter Sanyó on 18.04.24.
//

import Foundation
import SwiftUI

struct creditScreen: View {
    @State private var expanded: Bool = false
    
    var body: some View {
        Button {
            withAnimation {
                expanded.toggle()
            }
        } label: {
            VStack {
                if expanded {
                    ScrollView {
                        VStack(spacing: 10) {
                            header
                            descText
                            teamText
                            credits
                        }
                        .padding()
                    }
                    .scrollIndicators(.visible)
                    .frame(maxWidth: 300, maxHeight: 400)
                }
                
                HStack {
                    if expanded {
                        Spacer()
                    }
                    Image(systemName: "info.circle")
                        .padding()
                        .contentShape(Circle())
                }
                .padding(0)
            }
            .padding(0)
        }
        .buttonStyle(.plain)
        .background(Color.darkGreen.opacity(0.09))
        .background(Material.ultraThin)
        .frame(maxWidth: expanded ? 300 : 51)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    private var header: some View {
        VStack {
            Image(systemName: "tree")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
                
            Text("Hamba")
                .font(.system(.title, design: .serif))
                .bold()
        }
        .foregroundColor(Color.darkGreen)
    }
    
    // MARK: - Contributors
    
    private var credits: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Contributors")
                    .font(.system(.title2, design: .serif))
                Spacer()
            }
            
            member(name1: "Rory Mason", name2: "Anzhela Schults")
            member(name1: "Kenan", name2: "Sridhar Ashok")
        }
    }
    
    // MARK: - TEAM
    
    private var teamText: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Team")
                    .font(.system(.title2, design: .serif))
                Spacer()
            }
            
            member(name1: "Thomas Frey", name2: "Wessel Weernink")
            member(name1: "Paul Schilling", name2: "Gabriel Rein")
            member(name1: "Péter Sanyó", name2: "")
        }
        .padding(.bottom)
    }
    
    private struct member: View {
        let name1: String
        let name2: String
        var body: some View {
            HStack {
                Text(name1)

                Spacer()
                
                Text(name2)
            }
            .font(.system(.footnote, design: .serif))
            .minimumScaleFactor(0.8)
            .lineLimit(1)
        }
    }
    
    // MARK: Description Body
    
    private var descText: some View {
        Text(bodyText)
            .font(.system(.footnote, design: .serif))
    }
    
    private var bodyText =
        """
        Hamba shows its users beautiful, hand-picked spots in and around Berlin. Each spot provides the user with a bench to sit on, and a beautiful view to enjoy.

        For those trying to get out of the house, discover new places, and connect with the city they live in and the communities they are surrounded by..

        Hamba is a student project, and we will work on improving Hamba one step at a time, with care and joy. We are looking forward to share this journey with you.

        """
}

#Preview {
    creditScreen()
}
