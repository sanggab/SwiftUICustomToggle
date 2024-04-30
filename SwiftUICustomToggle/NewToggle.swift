//
//  NewToggle.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/30.
//

import SwiftUI

public struct NewToggle<ContentView: View>: View {
    @Binding public var isOn: Bool
    
    public private(set) var label: () -> ContentView
    public var model: CustomToggleModel = .init(spacing: .zero, buttonSize: .init(width: 36, height: 20), buttonRadius: 10)
    public var isOnBgColor: Color = .yellow
    public var isOffBgColor: Color = .gray
    
    
    public var circlePadding: CirclePadding = CirclePadding(.all, 0)
    
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
                .fill(isOn ? isOnBgColor : isOffBgColor)
                .frame(width: model.buttonSize.width, height: model.buttonSize.height)
                .overlay {
                    AsyncImage(url: URL(string: "https://upload3.inven.co.kr/upload/2023/04/03/bbs/i16565482795.jpg")) { image in
                        image.resizable()
                    } placeholder: {
                        EmptyView()
                    }
                    .frame(width: model.buttonSize.width, height: model.buttonSize.height)
                    .cornerRadius(model.buttonRadius)
                }
                .overlay {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .padding(circlePadding.edges, circlePadding.length)
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
    
    @inlinable public func custom(_ model: CustomToggleModel) -> NewToggle {
        var view = self
        view.model = model
        return view
    }
    
    @inlinable public func changeColor(on: Color = .yellow, off: Color = .gray) -> NewToggle {
        var view = self
        view.isOnBgColor = on
        view.isOffBgColor = off
        return view
    }
    
    @inlinable public func circleStyle(_ padding: CirclePadding) -> NewToggle {
        var view = self
        view.circlePadding = padding
        return view
    }
}

#Preview {
    ContentView()
}
