//
//  ToggleStateView.swift
//  StartSwiftUI
//
//  Created by Irsyad Ashari on 14/05/24.
//

import SwiftUI

struct ToggleStateView: View {
    @State private var isOn = false
    
    var body: some View {
        VStack {
            
            Toggle(isOn: $isOn) {
                Text("")
            }.labelsHidden()
            
            Text(self.isOn ? "🌞" : "🌙").font(.custom("Arial", size: 90))
            
        }
    }
}

#Preview {
    ToggleStateView()
}
