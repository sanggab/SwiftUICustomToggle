//
//  CustomToggleView.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

import SwiftUI

public struct CustomToggleView<ContentView: View>: View {
    @Binding public var isOn: Bool
    
    public var label: () -> ContentView
    
    private var model: ToggleModel = .init()
    
    public init(isOn: Binding<Bool>,
         @ViewBuilder label: @escaping () -> ContentView) {
        self._isOn = isOn
        self.label = label
    }
    
    public var body: some View {
        HStack(spacing: model.spacing) {
            label()
                .animation(nil, value: UUID())
            
            RoundedRectangle(cornerRadius: model.buttonRadius)
                .fill(isOn ? .yellow : .gray)
                .frame(width: model.buttonSize.width, height: model.buttonSize.height)
                .overlay {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: model.circleSize.width, height: model.circleSize.height)
                            .padding(.leading, !isOn ? model.circleInset : 0)
                            .padding(.trailing, isOn ? model.circleInset : 0)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: isOn ? .trailing : .leading)
                }
                .onTapGesture {
                    withAnimation {
                        isOn.toggle()
                    }
                }
        }
    }
    
    public func custom(model: ToggleModel) -> CustomToggleView {
        var view = self
        view.model = model
        return view
    }
    
//    public enum 
}

#Preview {
    ContentView()
}
