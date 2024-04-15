//
//  CoreDataManager.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/26/22.
//

import Foundation

class CoreDataVM: ObservableObject {
    static func createModel() -> CoreDataViewModel {
        CoreDataViewModel()
    }
    
    @Published private var model: CoreDataViewModel
    
    init() {
        model = CoreDataVM.createModel()
    }
}

extension CoreDataVM {
    var notes: [Note] {
        model.notes
    }
    
    var stringDates: [String] {
        model.stringDates
    }
    
    var gameOver: Bool {
        model.gameOver
    }
    
    var currentNote: Note? {
        model.currentNote
    }
    
    func fetchDate(of selectedDate: String) {
        model.fetchDate(of: selectedDate)
    }
    
    func addNote(WORD: String, TYPE: String, DEFINITION: String) {
        model.addNote(WORD: WORD, TYPE: TYPE, DEFINITION: DEFINITION)
    }
    
    func remove(_ note: Note) {
        model.remove(note)
    }
    
    func update(note: Note, WORD: String, TYPE: String, DEFINITION: String) {
        model.update(note: note, WORD: WORD, TYPE: TYPE, DEFINITION: DEFINITION)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        model.move(from: source, to: destination)
    }
    
    func startGame() {
        model.startGame()
    }
    
    func nextStage() {
        model.nextStage()
    }
    
    func reset() {
        model.reset()
    }
    
    func clearNotes() {
        model.clearNotes()
    }
}
