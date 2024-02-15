//
//  mapStyleButton.swift
//  Hamba
//
//  Created by Péter Sanyó on 15.02.24.
//

import SwiftUI
import _MapKit_SwiftUI

///// Buttons to toggle which map type to display.
//struct mapStyleButton: View {
//    @ObservedObject var mapViewModel: MapViewModel
//    @State private var isImageryMapType: Bool = false
//
//    var body: some View {
//            VStack(alignment: .trailing) {
//                Spacer()
//                Button(action: {
//                    // 2. Toggle the map type on button press
//                    isImageryMapType.toggle()
//                    mapViewModel.mapType = isImageryMapType ? MapStyle.imagery : MapStyle.standard
//                }, label: {
//                    // 3. Change the button icon based on the toggle status
//                    Image(systemName: isImageryMapType ? "square.2.layers.3d.top.filled" : "square.2.layers.3d.bottom.filled")
//                })
//                .buttonStyle(.plain)
//            }
//        }
//}
//
//#Preview {
//    mapStyleButton(mapViewModel: MapViewModel())
//}
