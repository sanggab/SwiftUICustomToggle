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
    
    private var circleSize: CGSize = .zero
    private var circleColor: Color = .red
    private var circlePadding: CGFloat = .zero
    
    private var circleSyle: CircleStyle = CircleStyle()
    
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
                .overlay {
                    AsyncImage(url: URL(string: bgImageString)) { image in
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
                            .fill(circleColor)
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
    func circleSize(_ size: CGSize = .zero) -> NewToggle {
        var view = self
        view.circleSize = size
        return view
    }
    
    /// 토글 버튼 Circle의 Padding
    /// Egde는 All로 들어간다. 주의할 점은 On / Off 시의 padding을 다 적용시키기 떄문에 이후에 isOnCircleEdge 이나 isOffCircleEdge를 적용시킬때 조심
    func circlePadding(_ length: CGFloat = 2) -> NewToggle {
        var view = self
//        view.circleOnPadding = CirclePadding(.all, length)
//        view.circleOffPadding = CirclePadding(.all, length)
        return view
    }
    
    /// Toggle Button Circle On padding
    func isOnCircleEdge(_ padding: CirclePadding = CirclePadding(.all, 2)) -> NewToggle {
        var view = self
//        view.circleOnPadding = padding
        
        return view
    }
    
    /// Toggle Button Circle Off padding
    func isOffCircleEdge(_ padding: CirclePadding = CirclePadding(.all, 2)) -> NewToggle {
        var view = self
//        view.circleOffPadding = padding
        return view
    }
    
    /// Toggle Button Circle Bacgkround Color
    func circleColor(_ color: Color = .white) -> NewToggle {
        var view = self
        view.circleColor = color
        return view
    }
}

private extension NewToggle {
    
    func test(_ padding: CirclePadding) {
        switch padding.edges {
        case .all:
            print("all")
        case .leading:
            print("leading")
        case .trailing:
            print("trailing")
        case .top:
            print("top")
        case .bottom:
            print("bottom")
        case .horizontal:
            print("horizontal")
        case .vertical:
            print("vertical")
        default:
            print("멍미?")
        }
    }
}

#Preview {
    ContentView()
}
