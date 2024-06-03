//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by mfelipesp on 29/05/24.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding
    var scrum: DailyScrum
    
    @State
    private var newAttendeesName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length") // This label is only to VoiceOver.
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true) // Just have at Slider.
                }
                //Voice Over: "Length, 5 minutes, adjustable"
                
                ThemePicker(selection: $scrum.theme)
                //Voice Over: "Theme, Orange, Button"
            }
            
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }.onDelete(perform: { indexSet in
                    scrum.attendees.remove(atOffsets: indexSet)
                })
                HStack {
                    TextField("New attendee", text: $newAttendeesName)
                    Button(action: {
                        //Animation to add new Attendee.
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeesName)
                            scrum.attendees.append(attendee)
                            newAttendeesName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeesName.isEmpty)
                    //Button VoiceOver: "Add attendee, Button, Not Enabled"
                }
            }
        }
    }
}

#Preview {
    DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
}
