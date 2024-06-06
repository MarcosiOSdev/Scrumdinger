//
//  NavigationScrum.swift
//  Scrumdinger
//
//  Created by mfelipesp on 04/06/24.
//

import SwiftUI

struct NavigationScrum<ContentView>: View where ContentView: View {
    
    private let content: () -> ContentView
    
    init(@ViewBuilder content: @escaping () -> ContentView) {
        self.content = content
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content()
            }
        } else {
            NavigationView {
                content()
            }
        }
    }
}
