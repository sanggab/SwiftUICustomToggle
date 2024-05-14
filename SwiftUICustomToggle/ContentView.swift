//
//  ContentView.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

import SwiftUI

struct ContentView: View {
    @State private var state: Bool = false
    
    @State private var id: UUID = UUID()
    
    public var bgImageString: String = "https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D"
    
    var body: some View {
//        Toggle(isOn: $state) {
//            Text(state ? "ON" : "OFF")
//        }
//        .accessibilityIdentifier("MyToggle")
//        
//        Button {
//            state.toggle()
//        } label: {
//            Text(state ? "ON" : "OFF")
//        }
//        .accessibilityIdentifier("MyButton")
        
//        VStack {
//            Rectangle()
//                .fill(.orange)
//                .frame(width: 100, height: 100)
//                .onTapGesture {
//                    id = UUID()
//                }
//            
//            NewToggle(isOn: $state) {
//                Text(state ? "ON" : "OFF")
//                    .frame(maxWidth: 36)
//            }
//            .changeColor(on: .mint, off: .pink)
//            .replaceCustomBackgroundView {
//                AsyncImage(url: URL(string: bgImageString)) { image in
//                    image.resizable()
//                } placeholder: {
//                    EmptyView()
//                }
//                .frame(width: 36, height: 20)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//            }
//            .knobPadding(.all, 2)
//            .knobColor(state ? .pink : .mint)
//            .accessibilityIdentifier("NewToggle")
//        }
//        .id(id)
        
        ZStack {
            NewToggle(isOn: $state) {
                Text(state ? "ON" : "OFF")
            }
//            .knobPadding(.all, 2)
//            .knobColor(.pink)
//            .knobColor(on: .pink, off: .blue)
//            .replaceCustomBackgroundView {
//                AsyncImage(url: URL(string: bgImageString)) { image in
//                    image.resizable()
//                } placeholder: {
//                    EmptyView()
//                }
//                .frame(width: 36, height: 20)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//            }
            .addViewAboveKnob {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onTapGesture {
            withAnimation {
                state.toggle()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
