//
//  CustomToggleView.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

//import SwiftUI
//
//public struct CustomToggleView<ContentView: View>: View {
//    @Binding public var isOn: Bool
//    
//    public private(set) var label: () -> ContentView
//    public private(set) var model: ToggleModel = .init()
//    public private(set) var isOnBgColor: Color = .yellow
//    public private(set) var isOffBgColor: Color = .gray
//    
//    public init(isOn: Binding<Bool>,
//         @ViewBuilder label: @escaping () -> ContentView) {
//        self._isOn = isOn
//        self.label = label
//    }
//    
//    public var body: some View {
//        HStack(spacing: model.spacing) {
//            label()
//                .animation(nil, value: UUID())
//            
//            RoundedRectangle(cornerRadius: model.buttonRadius)
//                .fill(isOn ? isOnBgColor : isOffBgColor)
//                .frame(width: model.buttonSize.width, height: model.buttonSize.height)
//                .overlay {
//                    ZStack {
//                        Circle()
//                            .fill(.white)
//                            .frame(width: model.circleSize.width, height: model.circleSize.height)
//                            .padding(.leading, !isOn ? model.circleInset : 0)
//                            .padding(.trailing, isOn ? model.circleInset : 0)
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: isOn ? .trailing : .leading)
//                }
//                .onTapGesture {
//                    withAnimation {
//                        isOn.toggle()
//                    }
//                }
//        }
//    }
//    
//    public func custom(model: ToggleModel) -> CustomToggleView {
//        var view = self
//        view.model = model
//        return view
//    }
//    
//    public func changeColor(on: Color = .yellow, off: Color = .gray) -> CustomToggleView {
//        var view = self
//        view.isOnBgColor = on
//        view.isOffBgColor = off
//        return view
//    }
//}
//
//#Preview {
//    ContentView()
//}
