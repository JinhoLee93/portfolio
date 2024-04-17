//
//  CellNoteView.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/13/22.
//

import SwiftUI

struct CellNoteView: View {
    let note: Note
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("[\(note.type!)] \(note.definition!)")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(note.word!)
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                        .foregroundColor(note.isMemorized ? .green : .textColor)
                        .opacity(0.8)
                }
            }
        }
    }
}
