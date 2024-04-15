//
//  CoreDataModel.swift
//  WordsADay
//
//  Created by Jinho Lee on 4/2/22.
//

import CoreData
import Foundation

struct CoreDataViewModel {
    private let noteContainer: NSPersistentContainer
    private var currentDate = Date()
    
    private(set) var notes: [Note]
    private(set) var stringDates: [String]
    private(set) var selectedDate: String
    private(set) var currentNote: Note? = nil
    private(set) var gameOver: Bool
    private(set) var stage: Int
    
    init() {
        noteContainer = NSPersistentContainer(name: "NoteDataModel")
        noteContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Unable to Access Note Data \(error)")
            }
        }
        
        selectedDate = CoreDataViewModel.stringYearMonth(for: Date())
        notes = []
        stringDates = []
        gameOver = false
        stage = 0
        
        loadDates()
        fetchNotes()
    }
}

extension CoreDataViewModel {
    mutating func fetchDate(of selectedDate: String ) {
        self.selectedDate = selectedDate
        fetchNotes()
    }
    
    mutating func fetchNotes() {
        let request = NSFetchRequest<Note>(entityName: "Note")
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.order, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "date == %@", selectedDate)
        do {
            notes = try noteContainer.viewContext.fetch(request)
            for note in notes {
                if !stringDates.contains(note.date!) {
                    stringDates.append(note.date!)
                }
            }
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    mutating func clearNotes() {
        notes.removeAll()
    }
    
    mutating func loadDates() {
        var allNotes: [Note] = []
        let request = NSFetchRequest<Note>(entityName: "Note")
        do {
            allNotes = try noteContainer.viewContext.fetch(request)
            stringDates.removeAll()
            for note in allNotes {
                if !stringDates.contains(note.date!) {
                    stringDates.append(note.date!)
                }
            }
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    mutating func addNote(WORD: String, TYPE: String, DEFINITION: String) {
        do {
            let curDate = CoreDataViewModel.stringYearMonth(for: Date())
            let note = Note(context: noteContainer.viewContext)
            note.date = curDate
            note.id = UUID()
            note.order = (notes.last?.order ?? 0) + 1
            note.word = WORD
            note.type = TYPE
            note.definition = DEFINITION
            note.isMemorized = false
            
            save()
        }
    }
    
    mutating func remove(_ note: Note) {
        guard let idx = notes.firstIndex(where: {$0.id == note.id}) else { return }
        notes.remove(at: idx)
        noteContainer.viewContext.delete(note)
        
        if notes.isEmpty {
            guard let idx = stringDates.firstIndex(where: { $0 == CoreDataViewModel.stringYearMonth(for: currentDate) }) else { return }
            stringDates.remove(at: idx)
        }

        save()
    }
    
    mutating func update(note: Note, WORD: String, TYPE: String, DEFINITION: String) {
        guard let idx = notes.firstIndex(where: {$0.id == note.id}) else { return }
        notes[idx].word = WORD
        notes[idx].type = TYPE
        notes[idx].definition = DEFINITION
        save()
    }
    
    mutating func move(from source: IndexSet, to destination: Int) {
        let itemToMove = source.first!
        
        if itemToMove < destination {
            var startIndex = itemToMove + 1
            let endIndex = destination - 1
            var startOrder = notes[itemToMove].order
            while startIndex <= endIndex {
                notes[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            notes[itemToMove].order = startOrder
        } else if destination < itemToMove {
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder = notes[destination].order + 1
            let newOrder = notes[destination].order
            while startIndex <= endIndex {
                notes[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            notes[itemToMove].order = newOrder
        }
        
        save()
    }
    
    mutating func save() {
        do {
            try? noteContainer.viewContext.save()
            fetchNotes()
        }
    }
    
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
    
    static func stringYearMonth(for targetDate: Date) -> String {
        let DF = DateFormatter()
        DF.dateFormat = "YYYY M d"
        
        let date = DF.string(from: targetDate)
        
        return date.components(separatedBy: " ").joined(separator: ".")
    }
}
