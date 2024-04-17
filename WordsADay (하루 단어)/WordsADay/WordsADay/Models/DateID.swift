//
//  DateID.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/23/22.
//

import Foundation

struct DateID: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}
