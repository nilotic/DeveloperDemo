//
//  TimerPickerView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TimerPickerView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var hours: UInt
    @Binding var minutes: UInt
    @Binding var seconds: UInt
    
    // MARK: Private
    private let hourRange: ClosedRange<UInt> = 0...23
    private let minuteRange: ClosedRange<UInt> = 0...59
    private let secondRange: ClosedRange<UInt> = 0...59
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 0) {
            hoursView
            minutesView
            secondsView
        }
        .frame(height: 120)
        .clipped()
    }
    
    // MARK: Private
    private var hoursView: some View {
        ZStack {
            Text("hour")
                .padding(.leading, 40)
            
            Picker("", selection: $hours) {
                ForEach(hourRange, id: \.self) {
                    Text(verbatim: "\($0)")
                        .padding(.trailing, 20)
                        .tag($0)
                }
            }
            .pickerStyle(.wheel)
        }
    }
    
    private var minutesView: some View {
        ZStack {
            Text("minute")
                .padding(.leading, 40)
            
            Picker("", selection: $minutes) {
                ForEach(minuteRange, id: \.self) {
                    Text(verbatim: "\($0)")
                        .padding(.trailing, 20)
                        .tag($0)
                }
            }
            .pickerStyle(.wheel)
        }
    }
    
    private var secondsView: some View {
        ZStack {
            Text("second")
                .padding(.leading, 40)
            
            Picker("", selection: $seconds) {
                ForEach(secondRange, id: \.self) {
                    Text(verbatim: "\($0)")
                        .padding(.trailing, 20)
                        .tag($0)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

#if DEBUG
#Preview {
    TimerPickerView(hours: .constant(1), minutes: .constant(1), seconds: .constant(20))
}
#endif
