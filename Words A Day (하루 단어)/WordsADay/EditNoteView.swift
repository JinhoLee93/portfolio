//
//  EditNoteView.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/13/22.
//

import SwiftUI

struct EditNoteView: View {
    var note: Note
    @ObservedObject var model: CoreDataVM
 
    @State private var WORD = ""
    @State private var TYPE = ""
    @State private var DEFINITION = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    TextField(note.word!, text: $WORD)
                    TextField(note.type!, text: $TYPE)
                }
                .padding(.leading, NoteConstants.GroupPadding)
                .textFieldStyle(.plain)
                
                
                ZStack(alignment: .leading) {
                    TextEditor (
                        text: $DEFINITION
                    )
                        .frame(minHeight: NoteConstants.minHeight, alignment: .leading)
                        .foregroundColor(.textColor)
                        .allowsTightening(true)
                        .padding(.leading, NoteConstants.textDEFpadding)
                    
                    if DEFINITION == "" {
                        Text(note.definition!)
                            .foregroundColor(.gray)
                            .font(font())
                            .opacity(NoteConstants.opacity)
                            .padding(.leading, NoteConstants.DEFpadding)
                    }
                }
            }
            .disableAutocorrection(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Editing \(note.word!)")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            let newWORD = (WORD == "") ? note.word : WORD
            let newTYPE = (TYPE == "") ? note.type : TYPE
            let newDEFINITION = (DEFINITION == "") ? note.definition : DEFINITION
            
            model.update(note: note, WORD: newWORD!, TYPE: newTYPE!, DEFINITION: newDEFINITION!)
            dismiss()
        }) {
            Text("Done")
        }
        .foregroundColor(.black)
    }
    
    private func font() -> Font {
        Font.system(size: NoteConstants.fontSize)
    }
    
    struct NoteConstants {
        static let GroupPadding: CGFloat = 10
        static let minHeight: CGFloat = 40
        static let textDEFpadding: CGFloat = 5.5
        static let fontSize: CGFloat = 17
        static let opacity: CGFloat = 0.5
        static let DEFpadding: CGFloat = 10
    }
}
