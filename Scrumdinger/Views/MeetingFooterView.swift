//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by mfelipesp on 31/05/24.
//

import SwiftUI

struct MeetingFooterView: View {
    
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()->Void
    
    // Get number of Speaker
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    
    // Verify if its the last speaker.
    private var isLastSpeaker: Bool {
//        speakers.dropLast().reduce(true) { $0 && $1.isCompleted }
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers"}
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction, label: {
                        Image(systemName: "forward.fill")
                    })
                    .accessibilityLabel("Next speaker") // "Next speaker. Button" VoiceOver reads it because of button.
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
