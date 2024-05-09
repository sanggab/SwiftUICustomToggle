//
//  ToggleModifier.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

import SwiftUI


/// Knob Padding
///
/// Switch의 Knob의 Padding 모델
/// 잡는 방식은 padding() modifier랑 동일하다
///
/// - Parameters:
///   - edges: The set of edges to pad for this view. The default
///     is ``Edge/Set/all``.
///   - length: An amount, given in points, to pad this view on the
///     specified edges. The default value of this parameter is `zero`.
@frozen
public struct KnobPadding: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(edges.rawValue)
        hasher.combine(length)
    }
    
    public var edges: Edge.Set
    public var length: CGFloat
    
    public init(_ edges: Edge.Set = .all, _ length: CGFloat = .zero) {
        self.edges = edges
        self.length = length
    }
}

/// Toggle Model
///
/// 기본적인 글자하고 버튼의 간격, 버튼 사이즈, 버튼 radius를 다룬다
///
/// - Parameters:
///   - spacing: Label하고 Switch 사이의 간격. 기본값은 `zero`.
///   - buttonSize: Switch의 사이즈. 기본값은 `CGSize(width: 36, height: 20)`.
///   - buttonRadius: Switch의 CorenrRadius. 기본값은 `20`.
@frozen
public struct CustomToggleModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(spacing)
        hasher.combine(buttonSize.width)
        hasher.combine(buttonSize.height)
        hasher.combine(buttonRadius)
    }
    
    public var spacing: CGFloat
    public var buttonSize: CGSize
    public var buttonRadius: CGFloat
    
    public init(spacing: CGFloat = .zero,
                buttonSize: CGSize = CGSize(width: 36, height: 20),
                buttonRadius: CGFloat = 20) {
        self.spacing = spacing
        self.buttonSize = buttonSize
        self.buttonRadius = buttonRadius
    }
}
