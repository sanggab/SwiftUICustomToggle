//
//  ContentView.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

import SwiftUI

struct ContentView: View {
    @State private var state: Bool = false
    
    var body: some View {
//        Toggle(isOn: $state) {
//            Text(state ? "ON" : "OFF")
//        }
        
        CustomToggleView(isOn: $state) {
            Text(state ? "ON" : "OFF")
                .frame(maxWidth: 36)
        }
        
        
    }
}

#Preview {
    ContentView()
}
