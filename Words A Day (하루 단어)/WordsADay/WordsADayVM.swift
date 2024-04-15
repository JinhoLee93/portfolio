//
//  WordsADayVM.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/6/22.
//

import CoreData
import Foundation

class WordsADayVM: ObservableObject {
    static func start() -> WordsADay {
        WordsADay()
    }
    
    @Published var model: WordsADay = start()
    
    /* Logistics */
    func move(from source: IndexSet, to destination: Int) {
        model.move(from: source, to: destination)
    }
    /* Logistics */
    
    /* Note Related */
    var notes: Array<Note> {
        model.notes
    }
    
    var count: Int {
        model.notes.count
    }
    
    func addNote(_ note: Note) {
        model.addNote(note)
    }
    
    
    func remove(_ note: Note) {
        model.remove(note)
    }
    /*
    func update(note: Note, WORD: String, TYPE: String, DEFINITION: String) {
        model.update(note: note, WORD: WORD, TYPE: TYPE, DEFINITION: DEFINITION)
    }
     */
    /* Note Related */
    
    /* Game Related */
    var currentNote: Note? {
        model.currentNote
    }
    
    var gameOver: Bool {
        model.gameOver
    }
    
    var stage: Int {
        model.stage
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
    /* Game Related */
}
