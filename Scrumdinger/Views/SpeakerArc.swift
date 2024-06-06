//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by mfelipesp on 06/06/24.
//

import SwiftUI

struct SpeakerArc: Shape {
    ///The speaker index indicates which attendee is speaking and how many segments to draw.
    let speakerIndex: Int
    
    /// number of arc segments on the number of total speakers.
    let totalSpeakers: Int
    
    /// calculate the degrees of a single arc
    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }
    
    
    /// Angle for the start and end of the arc.
    /// Additional 1.0 degree is for visual separation between arc segments.
    private var startAngle: Angle {
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }
    
    private var endAndgle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAndgle,
                clockwise: false
            )
        }
    }
}
