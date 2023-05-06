//
//  CustomToggle.swift
//  HealthGPT
//
//  Created by Giorgio Giannotta on 06/05/23.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "sun.max" : "moon.fill")
                    .foregroundColor(configuration.isOn ? .orange : .yellow)
            }
            .padding()
            .background(configuration.isOn ? Color.white : Color.black)
            .cornerRadius(8)
            .shadow(radius: 2)
        }
    }
}
