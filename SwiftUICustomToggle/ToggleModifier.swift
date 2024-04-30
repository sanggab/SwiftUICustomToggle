//
//  ToggleModifier.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

import SwiftUI

@frozen
public struct CirclePadding: Hashable {
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

@frozen
public struct CustomToggleModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(spacing)
        hasher.combine(buttonSize.width)
        hasher.combine(buttonSize.height)
    }
    
    public var spacing: CGFloat
    public var buttonSize: CGSize
    public var buttonRadius: CGFloat
}
