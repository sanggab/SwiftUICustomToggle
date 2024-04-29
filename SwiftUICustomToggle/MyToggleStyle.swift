//
//  MyToggleStyle.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

import SwiftUI

public struct ToggleModel: Equatable {
    public var spacing: CGFloat
    
    public var labelSize: CGSize
    
    public var buttonRadius: CGFloat
    public var buttonSize: CGSize
    
    public var circleSize: CGSize
    public var circleInset: CGFloat
    
    public init(spacing: CGFloat = .zero,
                labelSize: CGSize = CGSize(width: 36, height: 22),
                buttonRadius: CGFloat = 10,
                buttonSize: CGSize = CGSize(width: 36, height: 20),
                circleSize: CGSize = CGSize(width: 16, height: 16),
                circleInset: CGFloat = 2) {
        self.spacing = spacing
        self.labelSize = labelSize
        self.buttonRadius = buttonRadius
        self.buttonSize = buttonSize
        self.circleSize = circleSize
        self.circleInset = circleInset
    }
}


public struct MyToggleStyle: ToggleStyle {
    
    @State private var circleColor: Color = .white
    @State private var isOnBgColor: Color = .yellow
    @State private var isOffBgColor: Color = .gray
    
    var model: ToggleModel
    
    
    public init(model: ToggleModel) {
        self.model = model
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: model.spacing) {
            configuration.label
                .frame(maxWidth: model.labelSize.width, maxHeight: model.labelSize.height)
                .animation(nil, value: UUID())
            
            RoundedRectangle(cornerRadius: model.buttonRadius)
                .fill(configuration.isOn ? isOnBgColor : isOffBgColor)
                .frame(width: model.buttonSize.width, height: model.buttonSize.height)
                .overlay {
                    ZStack {
                        Circle()
                            .fill(circleColor)
                            .frame(width: model.circleSize.width, height: model.circleSize.height)
                            .padding(.leading, !configuration.isOn ? model.circleInset : 0)
                            .padding(.trailing, configuration.isOn ? model.circleInset : 0)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: configuration.isOn ? .trailing : .leading)
                }
                .onTapGesture {
                    withAnimation {
                        configuration.$isOn.wrappedValue.toggle()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
