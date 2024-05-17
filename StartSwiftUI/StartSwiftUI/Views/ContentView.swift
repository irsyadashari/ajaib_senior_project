//
//  ContentView.swift
//  StartSwiftUI
//
//  Created by Irsyad Ashari on 14/05/24.
//

import SwiftUI

struct ContentView: View {
    let placeList = PlaceDetails.fetchMockList()
    
    var body: some View {
        NavigationView {
            List(placeList, id: \.name) { model in
                PlaceDetailCell(model: model)
                    .shadow(color: .black, radius: 5)
                    .padding(0)
            }
            
            .navigationTitle("Place List")
        }
    }
}

#Preview {
    ContentView()
}
