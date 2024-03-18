//
//  View+Navigation.swift
//  Hamba
//
//  Created by Péter Sanyó on 15.02.24.
//

import SwiftUI

///Forces .stack behaviour for NavigationView (phone/ipad)
extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
