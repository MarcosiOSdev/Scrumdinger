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
    
    @State
    private var isRecording = false
    
    @StateObject
    private var scrumTimer = ScrumTimer()
    
    @StateObject
    private var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            
            VStack {
                
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                
                MeetingTimerView(
                    speakers: scrumTimer.speakers,
                    theme: scrum.theme, 
                    isRecording: isRecording
                )
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            endScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        
        // this closure is when speak's time expires.
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        player.pause()
        let newHistory = History(
            attendees: scrum.attendees,
            transcript: speechRecognizer.transcript
        )
        scrum.history.insert(newHistory, at: 0)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
