//
//  PlaceDetailCell.swift
//  StartSwiftUI
//
//  Created by Irsyad Ashari on 14/05/24.
//

import SwiftUI

struct PlaceDetailCell: View {
    let model: PlaceDetails
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(model.name)
                    .foregroundColor(.white)
                    .font(Font.headline)
                    .padding()
                    .background(Color.white.opacity(0.5))
                Text(model.details)
                    .font(Font.subheadline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.05))
            }.background(Color.red.opacity(0.8))
        }.background(Image(model.image)
            .scaledToFit()
            .padding(1)
        )
    }
}

#Preview {
    PlaceDetailCell(model: PlaceDetails.fetchMockList().first!)
}
