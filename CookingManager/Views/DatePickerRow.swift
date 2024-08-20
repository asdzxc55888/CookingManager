//
//  DatePickerRow.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/20.
//

import SwiftUI

struct DatePickerRow: View {
    @Binding var selectedDate: Date
    @State private var currentWeekOfYear: Int
    @State private var currentYear: Int
    @State private var dragOffset: CGFloat = 0
    @Namespace private var circleAnimation
    
    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        self._currentWeekOfYear = .init(
            initialValue: selectedDate.wrappedValue.get(.weekOfYear)
        )
        self._currentYear = .init(wrappedValue: selectedDate.wrappedValue.get(.year))
    }
    
    private var totalWeeksInYear: Int {
        let calendar = Calendar.current
        guard let date = calendar.date(from: DateComponents(year: currentYear)) else {
            return 52
        }
        guard let range = calendar.range(of: .weekOfYear, in: .year, for: date) else {
            return 52
        }
        return range.count
    }
    
    var body: some View {
        Text(String(currentYear))
        Text(String(currentWeekOfYear))
        TabView(selection: $currentWeekOfYear) {
            ForEach(0...(totalWeeksInYear + 1), id: \.self) { week in
                WeekView(
                    weekOfYear: week,
                    year: currentYear,
                    selectedDate: $selectedDate
                )
                .tag(week)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onChange(of: currentWeekOfYear) { newWeek in
            handleWeekChange(to: newWeek)
        }
    }
}

//MARK: handler
extension DatePickerRow {
    private func handleWeekChange(to newWeek: Int) {
        let calendar = Calendar.current
    
        if newWeek < 1 {
            currentYear -= 1
            currentWeekOfYear = Calendar.current.range(of: .weekOfYear, in: .year, for: calendar.date(from: DateComponents(year: currentYear))!)!.count
        }
        else if newWeek > totalWeeksInYear {
            currentYear += 1
            currentWeekOfYear = 1
        }
    }
}

private struct WeekView: View {
    let weekOfYear: Int
    let year: Int
    @Binding var selectedDate: Date
    @Namespace private var circleAnimation
    
    private var weekDayRange: [Date.WeekDay] {
        return Date.getWeekDateRange(forWeek: weekOfYear, inYear: year)
    }

    var body: some View {
        HStack(spacing: Spacing.s) {
            ForEach(weekDayRange, id: \.id) { weekDay in
                makeDateCell(weekDay: weekDay)
            }
        }
    }

    @ViewBuilder
    private func makeDateCell(weekDay: Date.WeekDay) -> some View {
        let date = weekDay.date
        let selected = Calendar.current.isDate(selectedDate, inSameDayAs: date)
        let textColor = selected ? Color.white : CustomColor.darkGray

        VStack {
            Text(date.toString(dateFormat: "EEE"))
            Text(date.toString(dateFormat: "dd"))
        }
        .font(.system(size: 14, weight: selected ? .bold : .regular))
        .foregroundStyle(textColor)
        .background {
            if selected {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 44, height: 44)
                    .transition(.scale)
                    .matchedGeometryEffect(id: "Circle", in: circleAnimation)
            }
        }
        .frame(width: 44, height: 44)
        .onTapGesture {
            withAnimation(.easeInOut) {
                selectedDate = date
            }
        }
    }
}

private struct PreviewWrapper: View {
    @State private var selectedDate: Date = Date(timeIntervalSince1970: 1734701944)
    
    var body: some View {
        DatePickerRow(selectedDate: $selectedDate)
    }
}

#Preview {
    PreviewWrapper()
}
