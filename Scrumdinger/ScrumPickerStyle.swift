//
//  ScrumPickerStyle.swift
//  Scrumdinger
//
//  Created by mfelipesp on 04/06/24.
//

import SwiftUI

/// Modifier to use .navigationLink with iOS16 or later.
struct ScrumPickerStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.pickerStyle(.navigationLink)
        } else {
            content.pickerStyle(.inline)
        }
    }
}

extension Picker {
    /// Modifier to use .navigationLink with iOS16 or later.
    public func scrumPickerStyle() -> some View {
        modifier(ScrumPickerStyleModifier())
    }
}
