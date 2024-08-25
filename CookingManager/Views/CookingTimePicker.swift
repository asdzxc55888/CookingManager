//
//  CookingTimePicker.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/25.
//

import SwiftUI

struct CookingTimePicker: View {
    //MARK: seconds
    @Binding private var timeValue: TimeInterval
    @State private var hours: Int
    @State private var mins: Int
    
    init(timeValue: Binding<TimeInterval>) {
        self._timeValue = timeValue
        let (hours, mins) = timeValue.wrappedValue.toHoursAndMinutes()
        self._hours = .init(initialValue: hours)
        self._mins = .init(initialValue: mins)
    }
    
    var body: some View {
        HStack {
            Text(Image(systemName: "frying.pan.fill"))
                 
            Text("烹飪時間:")
                .font(.system(size: 14))
            
            makeNumberPicker(name: "小時", value: $hours, range: (0...24))
            makeNumberPicker(name: "分鐘", value: $mins, range: (1...60))
        }
        .onChange(of: hours, onPickerValueChange)
        .onChange(of: mins, onPickerValueChange)
    }
    
    @ViewBuilder
    private func makeNumberPicker(name: String, value: Binding<Int>, range: ClosedRange<Int>) -> some View {
        Picker(name, selection: value) {
            ForEach(range, id:\.self) { value in
                Text(String(value))
                    .font(.system(size: 14))
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 60, height: 40)
        
        Text(name)
            .font(.system(size: 14))
    }
}

extension CookingTimePicker {
    private func onPickerValueChange() {
        timeValue = TimeInterval(hours * 3600 + mins * 60)
    }
}

private struct PreviewWrapper: View {
    @State private var timeValue: TimeInterval = 60
    
    var body: some View {
        CookingTimePicker(timeValue: $timeValue)
            .onChange(of: timeValue, {
                print(timeValue)
            })
    }
}

#Preview {
    PreviewWrapper()
}
