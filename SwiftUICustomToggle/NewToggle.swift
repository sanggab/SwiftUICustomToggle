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
//    private var model: ToggleModel = .init(spacing: .zero, buttonSize: .init(width: 36, height: 20), buttonRadius: 10)
//    private var isOnBgColor: Color = .yellow
//    private var isOffBgColor: Color = .gray
//    
//    private var isOnKnobEdge: EdgeInsets = EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
//    private var isOffKnobEdge: EdgeInsets = EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
//    
//    private var isOnKnobColor: Color = .white
//    private var isOffKnobColor: Color = .white
    
    @ObservedObject private var viewModel: CustomToggleViewModel = CustomToggleViewModel()
    
    private var customBackgroundView: AnyView?
    private var aboveKnobView: AnyView?
    
    public init(isOn: Binding<Bool>,
                @ViewBuilder label: @escaping () -> ContentView) {
        self._isOn = isOn
        self.label = label
        print("hi")
    }
    
    public var body: some View {
        HStack(spacing: viewModel(\.toggleModel.spacing)) {
            label()
                .animation(nil, value: UUID())
            
            RoundedRectangle(cornerRadius: viewModel(\.toggleModel.buttonRadius))
                .fill(isOn ? viewModel(\.toggleModel.isOnColor) : viewModel(\.toggleModel.isOffColor))
                .frame(width: viewModel(\.toggleModel.buttonSize.width), height: viewModel(\.toggleModel.buttonSize.height))
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
            .fill(isOn ? viewModel(\.knobModel.isOnColor) : viewModel(\.knobModel.isOffColor))
            .overlay {
                if let aboveKnobView {
                    aboveKnobView
                }
            }
            .padding(isOn ? viewModel(\.knobModel.edge.isOn) : viewModel(\.knobModel.edge.isOff))
    }
}


// MARK: Helper
public extension NewToggle {
    func custom(_ model: ToggleModel) -> NewToggle {
        let view = self
        view.viewModel.update(\.toggleModel, model)
        return view
    }
    
    func changeColor(on: Color = .yellow, off: Color = .gray) -> NewToggle {
        let view = self
//        view.isOnBgColor = on
//        view.isOffBgColor = off
        view.viewModel.update(\.toggleModel.isOnColor, on)
        view.viewModel.update(\.toggleModel.isOffColor, off)
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
//    func knobSize(_ size: CGSize = .zero) -> NewToggle {
//        var view = self
//        view.knobSize = size
//        return view
//    }
    
    func knobColor(_ color: Color = .white) -> NewToggle {
        let view = self
//        view.isOnKnobColor = color
//        view.isOffKnobColor = color
        view.viewModel.update(\.knobModel.isOnColor, color)
        view.viewModel.update(\.knobModel.isOffColor, color)
        return view
    }
    
    func knobColor(on: Color = .white, off: Color = .white) -> NewToggle {
        let view = self
//        view.isOnKnobColor = on
//        view.isOffKnobColor = off
        view.viewModel.update(\.knobModel.isOnColor, on)
        view.viewModel.update(\.knobModel.isOffColor, off)
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
        var edge = viewModel(\.knobModel.edge.isOn)
        
        switch padding.edges {
        case .all:
            edge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        case .leading:
            edge.leading += padding.length
        case .trailing:
            edge.trailing += padding.length
        case .top:
            edge.top += padding.length
        case .bottom:
            edge.bottom += padding.length
        case .horizontal:
            edge.leading += padding.length
            edge.trailing += padding.length
        case .vertical:
            edge.top += padding.length
            edge.bottom += padding.length
        default:
            edge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        }
        
        viewModel.update(\.knobModel.edge.isOn, edge)
    }
    
    mutating func calIsOffKnobEdge(_ padding: KnobPadding ) {
        var edge = viewModel(\.knobModel.edge.isOff)
        switch padding.edges {
        case .all:
            edge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        case .leading:
            edge.leading += padding.length
        case .trailing:
            edge.trailing += padding.length
        case .top:
            edge.top += padding.length
        case .bottom:
            edge.bottom += padding.length
        case .horizontal:
            edge.leading += padding.length
            edge.trailing += padding.length
        case .vertical:
            edge.top += padding.length
            edge.bottom += padding.length
        default:
            edge += EdgeInsets(top: padding.length, leading: padding.length, bottom: padding.length, trailing: padding.length)
        }
        
        viewModel.update(\.knobModel.edge.isOff, edge)
    }
}

#Preview {
    ContentView()
}
