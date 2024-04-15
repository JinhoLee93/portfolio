//
//  Calendar.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/23/22.
//

import SwiftUI

struct CustomCalendar: View {
    @State private var currentDate: Date = Date()
    @Binding var calendarIn: Bool
    @Binding var selectedDate: String
    @State private var currentMonth: Int = 0
    
    var model: CoreDataVM
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    calendarIn = false
                }
            VStack {
                let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                let calSubs = arrayYearMonth(for: currentDate)
                let dateSubs = arrayYearMonth(for: Date())
                
                // Year, Month and Buttons
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(calSubs[1])
                                .font(.title.bold())
                            
                            Text(calSubs[0])
                                .font(.title)
                                .fontWeight(.light)
                        }
                        .foregroundColor(.black)
                    }
                    Spacer(minLength: 0)
            
                    Button {
                        currentMonth -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    
                    Button {
                        currentMonth += 1
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(!(dateSubs == calSubs) ? .black : .gray)
                    }
                    .disabled(!(dateSubs == calSubs) ? false : true)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                // Days
                HStack(spacing: 0) {
                    ForEach(days, id: \.self) { day in
                        Text("\(day)")
                            .font(.callout)
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.black)
                }
                Divider()
                    .padding(.bottom, 10)
                
                // Dates
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(extractDate()) { value in
                        CardView(value: value)
                    }
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 30)
            .onChange(of: currentMonth) { newValue in
                currentDate = getCurrentMonth()
            }
            .background(
                Color.white
                .cornerRadius(30))
        }
        .zIndex(1)
        .disabled(calendarIn ? false : true)
    }
}

extension CustomCalendar {
    func CardView(value: DateID) -> some View {
        VStack {
            if value.day != -1 {
                ZStack {
                    if arrayYearMonth(for: value.date) == arrayYearMonth(for: Date()) {
                        Circle()
                            .opacity(0.3)
                            .foregroundColor(.pink)
                    }
                    Text("\(value.day)")
                        .foregroundColor(model.stringDates.contains(stringYearMonth(for: value.date)) ? .black : .gray)
                        .onTapGesture {
                            if model.stringDates.contains(stringYearMonth(for: value.date)) || (stringYearMonth(for: Date()) == stringYearMonth(for: value.date)) {
                                selectedDate = arrayYearMonth(for: value.date).joined(separator: ".")
                                withAnimation(Animation.easeInOut(duration: 0.3)) {
                                    calendarIn = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    model.fetchDate(of: selectedDate)
                                }
                            }
                        }
                }
                .frame(height: 40)
            }
        }
        .frame(height: 40, alignment: .top)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: Calendar.Component.month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateID] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateID in
            let day = calendar.component(.day, from: date)
            
            return DateID(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0 ..< firstWeekday - 1 {
            days.insert(DateID(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    func arrayYearMonth(for targetDate: Date) -> [String] {
        let DF = DateFormatter()
        DF.dateFormat = "YYYY M d"
        
        let date = DF.string(from: targetDate)
        
        return date.components(separatedBy: " ")
    }
    
    func stringYearMonth(for targetDate: Date) -> String {
        let DF = DateFormatter()
        DF.dateFormat = "YYYY M d"
        
        let date = DF.string(from: targetDate)
        
        return date.components(separatedBy: " ").joined(separator: ".")
    }
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
