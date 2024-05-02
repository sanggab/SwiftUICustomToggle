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
    private var model: CustomToggleModel = .init(spacing: .zero, buttonSize: .init(width: 36, height: 20), buttonRadius: 10)
    private var isOnBgColor: Color = .yellow
    private var isOffBgColor: Color = .gray
    
    public var bgImageString: String = "https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D"
    
    
    private var isTest: Bool = false
    
    private var circleOnEdge: EdgeInsets = EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
    private var circleOffEdge: EdgeInsets = EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
    
    @State private var testhoho: EdgeInsets = EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
    
    private var knobSize: CGSize = .zero
    private var knobColor: Color = .white
    
    public init(isOn: Binding<Bool>,
         @ViewBuilder label: @escaping () -> ContentView) {
        self._isOn = isOn
        self.label = label
        print("hi")
    }
    
    public var body: some View {
        HStack(spacing: model.spacing) {
            label()
                .animation(nil, value: UUID())
            
            RoundedRectangle(cornerRadius: model.buttonRadius)
                .fill(isOn ? isOnBgColor : isOffBgColor)
                .frame(width: model.buttonSize.width, height: model.buttonSize.height)
//                .overlay {
//                    AsyncImage(url: URL(string: bgImageString)) { image in
//                        image.resizable()
//                    } placeholder: {
//                        EmptyView()
//                    }
//                    .frame(width: model.buttonSize.width, height: model.buttonSize.height)
//                    .cornerRadius(model.buttonRadius)
//                }
                .overlay {
                    ZStack {
                        Circle()
                            .fill(knobColor)
                            .padding(isOn ? circleOnEdge : circleOffEdge)
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
    
    public func custom(_ model: CustomToggleModel) -> NewToggle {
        var view = self
        view.model = model
        return view
    }
    
    public func changeColor(on: Color = .yellow, off: Color = .gray) -> NewToggle {
        var view = self
        view.isOnBgColor = on
        view.isOffBgColor = off
        return view
    }
}

// MARK: CircleStyle Method
public extension NewToggle {
    func knobSize(_ size: CGSize = .zero) -> NewToggle {
        var view = self
        view.knobSize = size
        return view
    }
    
    func knobColor(_ color: Color = .white) -> NewToggle {
        var view = self
        view.knobColor = color
        return view
    }
    
    func knobPadding(_ edges: Edge.Set = .all, _ length: CGFloat = .zero) -> NewToggle {
        var view = self 
        
        return view
    }
    
//    /// 토글 버튼 Circle의 Padding
//    /// isOn, isOff에 padding이 똑같이 들어간다
//    func circleIndicatorEdge(_ padding: CirclePadding = CirclePadding(.all, 2)) -> NewToggle {
//        var view = self
//        view.calIsOnPadding(padding)
//        view.calIsOffPadding(padding)
//        return view
//    }
//    
//    /// Toggle Button Circle On padding
//    func isOnCircleEdge(_ edge: CirclePadding = CirclePadding(.all, 2)) -> NewToggle {
//        var view = self
//        view.calIsOnPadding(padding)
//        return view
//    }
//    
//    /// Toggle Button Circle Off padding
//    func isOffCircleEdge(_ padding: CirclePadding = CirclePadding(.all, 2)) -> NewToggle {
//        var view = self
//        view.calIsOffPadding(padding)
//        return view
//    }
}

private extension NewToggle {
    
    mutating func dd(_ padding: CirclePadding) {
        switch padding.edges {
        case .all:
            print("all")
            circleOnEdge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        case .leading:
            print("leading")
            circleOnEdge.leading += padding.length
        case .trailing:
            print("trailing")
            circleOnEdge.trailing += padding.length
        case .top:
            print("top")
            circleOnEdge.top += padding.length
        case .bottom:
            print("bottom")
            circleOnEdge.bottom += padding.length
        case .horizontal:
            print("horizontal")
            circleOnEdge.leading += padding.length
            circleOnEdge.trailing += padding.length
        case .vertical:
            print("vertical")
            circleOnEdge.top += padding.length
            circleOnEdge.bottom += padding.length
        default:
            print("멍미?")
        }
    }
    
    mutating func calIsOffPadding(_ padding: CirclePadding) {
        switch padding.edges {
        case .all:
            print("all")
            circleOffEdge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        case .leading:
            print("leading")
            circleOffEdge.leading += padding.length
        case .trailing:
            print("trailing")
            circleOffEdge.trailing += padding.length
        case .top:
            print("top")
            circleOffEdge.top += padding.length
        case .bottom:
            print("bottom")
            circleOffEdge.bottom += padding.length
        case .horizontal:
            print("horizontal")
            circleOffEdge.leading += padding.length
            circleOffEdge.trailing += padding.length
        case .vertical:
            print("vertical")
            circleOffEdge.top += padding.length
            circleOffEdge.bottom += padding.length
        default:
            print("멍미?")
        }
    }
}

#Preview {
    ContentView()
}
