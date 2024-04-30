//
//  ToggleModifier.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/04/26.
//

import SwiftUI


/// Circle Padding
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
public struct CircleStyle: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(size.width)
        hasher.combine(size.height)
        hasher.combine(color)
        hasher.combine(padding)
    }
    
    public var size: CGSize
    public var color: Color
    public var padding: CirclePadding
    
    public init(size: CGSize = .zero, color: Color = .white, padding: CirclePadding = CirclePadding(.all, 2)) {
        self.size = size
        self.color = color
        self.padding = padding
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
