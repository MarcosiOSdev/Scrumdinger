//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by mfelipesp on 31/05/24.
//

import SwiftUI

struct MeetingHeaderView: View {
    
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    
    private var minutesRemaing: Int {
        secondsRemaining / 60
    }
    
    /// Get value percentage
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaing")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remainging")
        .accessibilityValue("\(minutesRemaing) minutes")
        .padding([.top, .horizontal])
    }
}
struct MeetingHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(
            secondsElapsed: 60,
            secondsRemaining: 180,
            theme: .bubblegum)
        .previewLayout(.sizeThatFits)
    }
}
