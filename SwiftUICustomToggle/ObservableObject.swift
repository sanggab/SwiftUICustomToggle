//
//  ObservableObject.swift
//  SwiftUICustomToggle
//
//  Created by Gab on 2024/05/10.
//

import SwiftUI

final class CustomToggleViewModel: ObservableObject {
    
    struct KnobState: Equatable {
        var knobModel: KnobModel = KnobModel()
    }
    
    struct State: Equatable {
        var toggleModel: ToggleModel = ToggleModel()
    }
    
    @Published private var state: State = State()
    
    @Published private var knobState: KnobState = KnobState()
    
    public init() {
        print("CustomToggleViewModel init")
        print("toggleModel -> \(state.toggleModel)")
        print("knobModel -> \(knobState.knobModel)")
    }
    
    func callAsFunction<V: Equatable>(_ keyPath: KeyPath<CustomToggleViewModel.State, V>) -> V {
        return state[keyPath: keyPath]
    }
    
    func callAsFunction<V: Equatable>(_ keyPath: KeyPath<CustomToggleViewModel.KnobState, V>) -> V {
        return knobState[keyPath: keyPath]
    }

    func update<V: Equatable>(_ keyPath: WritableKeyPath<CustomToggleViewModel.State, V>, _ newValue: V) {
        state[keyPath: keyPath] = newValue
    }
    
    func update<V: Equatable>(_ keyPath: WritableKeyPath<CustomToggleViewModel.KnobState, V>, _ newValue: V) {
        knobState[keyPath: keyPath] = newValue
    }
}
