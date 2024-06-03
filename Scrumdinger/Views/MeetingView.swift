//
//  ContentView.swift
//  Scrumdinger
//
//  Created by mfelipesp on 28/05/24.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    
    private var player: AVPlayer {
        AVPlayer.sharedDingPlayer
    }
    
    @Binding
    var scrum: DailyScrum
    
    @StateObject
    var scrumTimer = ScrumTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            
            VStack {
                
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            
            // this closure is when speak's time expires.
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
