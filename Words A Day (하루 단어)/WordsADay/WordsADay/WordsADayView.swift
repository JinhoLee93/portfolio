//
//  ContentView.swift
//  WordsADay
//
//  Created by Jinho Lee on 2/28/22.
//

import SwiftUI

struct WordsADayView: View {
    @State private var selectedDate: String = WordsADayView.getDate(of: Date())
    @ObservedObject var model: CoreDataVM
    @State private var selectedNote: Note? = nil
    @State private var beingEdited: Note? = nil
    @State private var isWriting = false
    @State private var gameViewIn = false
    @State private var noteViewIn = false
    @State private var isCellPressed = false
    @State private var gameOver = false
    @State private var calendarIn = false
    @State private var savedDate: Date? = nil
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    List {
                        ForEach (model.notes) { note in
                            WordCell(note: note) {
                                isCellPressedToggle()
                                selectedNote = note
                            }
                                .swipeActions(allowsFullSwipe: false) {
                                    Group {
                                        Button(role: .destructive) { withAnimation { model.remove(note) } } label: { Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button(action: { beingEdited = note } ) {
                                            Image(systemName: "pencil")
                                        }
                                        .tint(.blue)
                                        .disabled(note.isMemorized ? true : false)
                                    }
                                    .disabled(selectedDate != WordsADayView.getDate(of: Date()) ? true : false)
                                }
                                .onDrag {
                                    return NSItemProvider()
                                }
                                .disabled(isCellPressed ? true : false)
                        }
                        .onMove(perform: model.move)
                    }
                }
                .sheet(item: $selectedNote, onDismiss: isCellPressedToggle) { note in
                    CellNoteView(note: note)
                }
                .sheet(item: $beingEdited) { note in
                    EditNoteView(note: note, model: model)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        calendar
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addButton
                            .disabled(selectedDate != WordsADayView.getDate(of: Date()) ? true : false)
                            .opacity(selectedDate != WordsADayView.getDate(of: Date()) ? 0 : 1)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        startGameButton
                            .disabled(model.notes.count > 0 ? false : true)
                            .opacity(gameViewIn || noteViewIn ? 0 : 1)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Color(UIColor.systemGray6))
            }
            .disabled(gameViewIn || noteViewIn || calendarIn)
            
            if calendarIn {
                CustomCalendar(calendarIn: $calendarIn, selectedDate: $selectedDate, model: model)
                    .opacity(calendarIn ? 1 : 0)
            }
             
            if noteViewIn {
                NoteView(noteViewIn: $noteViewIn, model: model)
                    .transition(.moveBothWays)
            }
            
            if gameViewIn {
                GameView(gameViewIn: $gameViewIn, model: model)
                    .transition(.moveBothWays)
            }
        }
    }
    
    /* Buttons Start */
    var startGameButton: some View {
        Button (action: {
            doAnimation {
                gameViewInToggle()
                model.startGame()
            }
        })
        {
            Image(systemName: "arrowtriangle.right.fill")
                .font(Font.system(size: ButtonConstants.startSize))
                .foregroundColor(model.notes.count > 0 ? .textColor : .gray)
        }
    }
    
    var addButton: some View {
        Button (action: {
            doAnimation {
                noteViewInToggle()
            }
        })
        {
            Image(systemName: "square.and.pencil")
                .foregroundColor(.textColor)
        }
    }
    
    var calendar: some View {
        Button (selectedDate) {
            withAnimation {
                calendarIn.toggle()
            }
        }
        .font(.headline)
        .foregroundColor(.textColor)
    }
    
    struct ButtonConstants {
        static let startSize:CGFloat = 30
    }
    /* Buttons End */
    
    /* Functions Start */
    func noteViewInToggle() {
        noteViewIn.toggle()
    }
    
    func gameViewInToggle() {
        gameViewIn.toggle()
    }
    
    func isCellPressedToggle() {
        isCellPressed.toggle()
    }
    
    private func doAnimation(of action: () -> Void) {
        let animation = Animation.easeInOut
        withAnimation(animation) {
            action()
        }
    }
    
    private func resetGame() {
        model.reset()
    }
    /* Functions End */
    
    /* Date Starts */
    private static func getDate(of date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "M"
        let month = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(from: date)
        
        return "\(year).\(month).\(day)"
    }
    /* Date Ends */
}

struct WordsADayView_Previews: PreviewProvider {
    static var previews: some View {
        let wordsADay = CoreDataVM()
        WordsADayView(model: wordsADay)
    }
}
