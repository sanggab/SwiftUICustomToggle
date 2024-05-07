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
    
    private var isOnKnobEdge: EdgeInsets = EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
    private var isOffKnobEdge: EdgeInsets = EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
    
    private var knobSize: CGSize = .zero
    private var knobColor: Color = .white
    
    private var customBackgroundView: AnyView?
    private var aboveKnobView: AnyView?
    
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
                    if let customBackgroundView {
                        customBackgroundView
                    }
                }
                .overlay {
                    knobView
                }
                .onTapGesture {
                    withAnimation {
                        isOn.toggle()
                    }
                }
        }
    }
    
    public var knobView: some View {
        ZStack {
            circleView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: isOn ? .trailing : .leading)
    }
    
    public var circleView: some View {
        Circle()
            .fill(knobColor)
            .overlay {
                if let aboveKnobView {
                    aboveKnobView
                }
            }
            .padding(isOn ? isOnKnobEdge : isOffKnobEdge)
    }
}


// MARK: Helper
public extension NewToggle {
    func custom(_ model: CustomToggleModel) -> NewToggle {
        var view = self
        view.model = model
        return view
    }
    
    func changeColor(on: Color = .yellow, off: Color = .gray) -> NewToggle {
        var view = self
        view.isOnBgColor = on
        view.isOffBgColor = off
        return view
    }
    // button의 background를 content로 교체한다
    func replaceCustomBackgroundView<V: View>(@ViewBuilder content: @escaping () -> V) -> NewToggle {
        var view = self
        view.customBackgroundView = AnyView(erasing: content())
        return view
    }
}

// MARK: Knob Method
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
        view.calIsOnKnobEdge(KnobPadding(edges, length))
        view.calIsOffKnobEdge(KnobPadding(edges, length))
        return view
    }
    
    func isOnKnobPadding(_ edges: Edge.Set = .all, _ length: CGFloat = .zero) -> NewToggle {
        var view = self
        view.calIsOnKnobEdge(KnobPadding(edges, length))
        return view
    }
    
    func isOffKnobPadding(_ edges: Edge.Set = .all, _ length: CGFloat = .zero) -> NewToggle {
        var view = self
        view.calIsOffKnobEdge(KnobPadding(edges, length))
        return view
    }
    
    func addViewAboveKnob<V: View>(@ViewBuilder content: @escaping () -> V) -> NewToggle {
        var view = self
        view.aboveKnobView = AnyView(erasing: content())
        return view
    }
    
}

private extension NewToggle {
    
    mutating func calIsOnKnobEdge(_ padding: KnobPadding) {
        switch padding.edges {
        case .all:
            isOnKnobEdge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        case .leading:
            isOnKnobEdge.leading += padding.length
        case .trailing:
            isOnKnobEdge.trailing += padding.length
        case .top:
            isOnKnobEdge.top += padding.length
        case .bottom:
            isOnKnobEdge.bottom += padding.length
        case .horizontal:
            isOnKnobEdge.leading += padding.length
            isOnKnobEdge.trailing += padding.length
        case .vertical:
            isOnKnobEdge.top += padding.length
            isOnKnobEdge.bottom += padding.length
        default:
            isOnKnobEdge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        }
    }
    
    mutating func calIsOffKnobEdge(_ padding: KnobPadding ) {
        switch padding.edges {
        case .all:
            isOffKnobEdge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        case .leading:
            isOffKnobEdge.leading += padding.length
        case .trailing:
            isOffKnobEdge.trailing += padding.length
        case .top:
            isOffKnobEdge.top += padding.length
        case .bottom:
            isOffKnobEdge.bottom += padding.length
        case .horizontal:
            isOffKnobEdge.leading += padding.length
            isOffKnobEdge.trailing += padding.length
        case .vertical:
            isOffKnobEdge.top += padding.length
            isOffKnobEdge.bottom += padding.length
        default:
            isOffKnobEdge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        }
    }
}

#Preview {
    ContentView()
}
