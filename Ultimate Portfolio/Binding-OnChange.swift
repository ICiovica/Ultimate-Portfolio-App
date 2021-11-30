//
//  Binding-OnChange.swift
//  Ultimate Portfolio
//
//  Created by Ionut Ciovica on 29/11/2021.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
