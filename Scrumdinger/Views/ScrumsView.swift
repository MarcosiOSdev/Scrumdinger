//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by mfelipesp on 28/05/24.
//

import SwiftUI

struct ScrumsView: View {
    
    @Binding
    var scrums: [DailyScrum]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State
    private var isPresentingNewScrumView = false
    
    let saveAction: ()->Void
    
    var body: some View {
        NavigationScrum {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrum")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }, label: {
                    Image(systemName: "plus")
                })
                .accessibilityLabel("New scrum")
            }
            .sheet(isPresented: $isPresentingNewScrumView) {
                NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
            }
            .onChange(of: scenePhase) { value in
                if value == .inactive { saveAction() }
            }
        }
    }
}

#Preview {
    ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
}
