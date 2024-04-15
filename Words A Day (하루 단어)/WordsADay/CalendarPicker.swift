//
//  CalendarPicker.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/22/22.
//

import SwiftUI

struct CalendarPicker: View {
    
    @Binding var showCalendar: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                DatePicker("Test", selection: $selectedDate)
                    .datePickerStyle(.graphical)
                    .clipped()
                
                Divider()
                HStack {
                    Button(action: {
                        withAnimation {
                            showCalendar = false
                        }
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showCalendar = false
                    }, label: {
                        Text("Save".uppercased())
                            .bold()
                    })
                    
                }
                .padding(.horizontal)

            }
            .padding()
            .background(
                Color.white
                    .cornerRadius(30)
            )
        }

    }
}
