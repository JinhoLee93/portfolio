//
//  WordCell.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/15/22.
//

import SwiftUI

struct WordCell: View {
    @ObservedObject var note: Note
    var setNote: () -> Void
    
    init(note: Note, setNote: @escaping () -> Void) {
        self.note = note
        self.setNote = setNote
    }
    
    var body: some View {
        Button(action: setNote) {
            HStack {
                Image(systemName: note.isMemorized ? "checkmark" : "minus")
                Text(note.word ?? "")
                    .font(font())
            }
            .foregroundColor(note.isMemorized ? .green : .textColor)
        }
    }
    
    private func font() -> Font {
        Font.system(size: DrawingConstants.fontSize)
    }
    
    private struct DrawingConstants {
        static let fontSize: CGFloat = 20
    }
}
    
