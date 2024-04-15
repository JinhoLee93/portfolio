//
//  WordsADay.swift
//  WordsADay
//
//  Created by Jinho Lee on 2/28/22.
//

import CoreData
import Foundation
import SwiftUI

struct WordsADay {
    private(set) var notes: Array<Note>
    private(set) var currentNote: Note? = nil
    private(set) var gameOver: Bool
    private(set) var stage: Int
    
    init() {
        notes = []
        gameOver = false
        stage = 0
    }
}

extension WordsADay {
    mutating func startGame() {
        if stage < notes.count {
            currentNote = notes[stage]
        } else {
            gameOver.toggle()
        }
    }
    
    mutating func nextStage() {
        notes[stage].isMemorized = true
        stage += 1
        startGame()
    }
    
    mutating func reset() {
        gameOver = false
        stage = 0
    }
    
    mutating func remove(_ note: Note) {
        if let idx = notes.firstIndex(where: {$0.id == note.id }) {
            notes.remove(at: idx)
        }
    }
    
    mutating func addNote(_ note: Note) {
        notes.append(note)
    }
    /*
    mutating func update(note: Note, WORD: String, TYPE: String, DEFINITION: String) {
        if let idx = notes.firstIndex(where: { $0.id == note.id } ) {
            notes[idx].update(WORD: WORD, TYPE: TYPE, DEFINITION: DEFINITION)
        }
    }
    */
    mutating func move(from source: IndexSet, to destination: Int) {
        notes.move(fromOffsets: source, toOffset: destination)
    }
}
