//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by mfelipesp on 28/05/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @State
    private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
