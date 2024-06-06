//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by mfelipesp on 29/05/24.
//

import SwiftUI

struct ThemePicker: View {
    
    @Binding
    var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .scrumPickerStyle()
    }
}

#Preview {
    ThemePicker(selection: .constant(.periwinkle))
}
