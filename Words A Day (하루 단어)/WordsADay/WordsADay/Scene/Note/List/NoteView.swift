//
//  NoteView.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/4/22.
//

import SwiftUI

struct NoteView: View {
    @Binding var noteViewIn: Bool
    @ObservedObject var model: CoreDataVM
    
    @State private var WORD: String = ""
    @State private var TYPE: String = ""
    @State private var DEFINITION: String = ""
    
    @State private var offset = CGSize.zero
    @State private var lastDragPosition: DragGesture.Value?
    @FocusState private var keyboardUp: FocusField?
    @State private var keyboard = FocusField.word
    let maxWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    TextField("Word", text: $WORD)
                        .focused($keyboardUp, equals: .word)
                        .onTapGesture {
                            keyboard = .word
                        }
                        .onSubmit {
                            keyboard = .type
                        }
    
                    TextField("Type", text: $TYPE)
                        .focused($keyboardUp, equals: .type)
                        .onTapGesture {
                            keyboard = .type
                        }
                        .onSubmit {
                            keyboard = .definition
                        }
                }
                .padding(.leading, NoteConstants.GroupPadding)
                .textFieldStyle(.plain)
                
                ZStack(alignment: .leading) {
                    TextEditor (
                        text: $DEFINITION
                    )
                    .onTapGesture {
                        keyboard = .definition
                    }
                    .focused($keyboardUp, equals: .definition)
                    .frame(minHeight: NoteConstants.minHeight, alignment: .leading)
                    .foregroundColor(.textColor)
                    .allowsTightening(true)
                    .padding(.leading, NoteConstants.textDEFpadding)
                    
                    if DEFINITION == "" {
                        Text("Definition")
                            .foregroundColor(.gray)
                            .font(font())
                            .opacity(NoteConstants.opacity)
                            .padding(.leading, NoteConstants.DEFpadding)
                    }
                }
            }
            .onChange(of: self.keyboardUp) { _ in
                self.keyboardUp = keyboard
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(Color(UIColor.systemGray6))
            .disableAutocorrection(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
                
                ToolbarItem(placement: .principal) {
                    Text("New Word")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
        }
        .onAppear {
            self.keyboardUp = .word
        }
        .zIndex(1)
    }
    
    /* Buttons Start */
    var backButton: some View {
        Button(action:
                {
                    self.keyboardUp = .none
                    doAnimation {
                        noteViewIn.toggle()
                    }
                })
        {
            Image(systemName: "chevron.backward.circle")
        }
        .foregroundColor(.textColor)
    }
    
    var addButton: some View {
        Button(action:
                {
                    self.keyboardUp = .none
                    doAnimation {
                        saveNote()
                    }
                })
        {
            Text("Done")
        }
        .foregroundColor(.textColor)
    }
    /* Buttons End */
    
    func saveNote() {
        if !(WORD == "" && TYPE == "" && DEFINITION == "") {
            model.addNote(WORD: WORD, TYPE: TYPE, DEFINITION: DEFINITION)
        }
        noteViewIn.toggle()
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

extension NoteView {
    enum FocusField: Hashable {
        case word
        case type
        case definition
    }
    
    private func doAnimation(of action: () -> Void) {
        withAnimation(.easeInOut(duration: 0.1)) {
            action()
        }
    }
}
