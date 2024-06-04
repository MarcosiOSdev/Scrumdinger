//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by mfelipesp on 01/06/24.
//

import SwiftUI

struct NewScrumSheet: View {
    
    @State
    private var newScrum = DailyScrum.emptyScrum
    
    @Binding
    var scrums: [DailyScrum]
    
    @Binding
    var isPresentingNewScrumView: Bool
    
    var body: some View {
        NavigationScrum {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}


struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(
            scrums: .constant(DailyScrum.sampleData),
            isPresentingNewScrumView: .constant(true))
    }
}
