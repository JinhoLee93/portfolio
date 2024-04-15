//
//  FortySecondsGame.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/12/22.
//

import Foundation

class FortySecondsGame: ObservableObject {
    typealias Letter = FortySeconds.Letter
    
    static func startGame() -> FortySeconds {
        FortySeconds()
    }
    
    @Published private var model = startGame()
    
    var wordMatched: Bool {
        model.wordMatched
    }
    
    var definition: String {
        model.DEFINITION
    }
    
    var type: String {
        model.TYPE
    }
    
    var stage: Int {
        model.stage
    }
    
    var isFinished: Bool {
        model.isFinished
    }
    
    var isSuccessful: Bool {
        model.isSuccessful
    }
    
    var answerBuffer: Array<Letter> {
        model.answerBuffer
    }
    
    var letterBuffer: Array<Letter> {
        model.letterBuffer
    }
    
    var shouldPrepare: Bool {
        model.shouldPrepare
    }
    
    var wrongAnswer: Bool {
        model.wrongAnswer
    }
    
    var rightAnswer: Bool {
        model.rightAnswer
    }
    
    func nextStage() {
        model.nextStage()
    }
    
    func matchedToggle() {
        model.matchedToggle()
    }
    
    func wrongAnswerToggle() {
        model.wrongAnswerToggle()
    }
    
    func prepToggle() {
        model.prepToggle()
    }
    
    func enter(in str: Letter) {
        model.enter(in: str)
    }
    
    func backspace() {
        model.backspace()
    }
    
    func restart() {
        model = FortySecondsGame.startGame()
    }
    
    func wordMatchedToggle() {
        model.wordMatchedToggle()
    }
    
    func letterToggle(for letter: FortySeconds.Letter) {
        model.letterToggle(for: letter)
    }
    
    func rightAnswerToggle() {
        model.rightAnswerToggle()
    }
    
    func ifWrong() {
        model.ifWrong()
    }
    
    func ifRight() {
        model.ifRight()
    }
}
