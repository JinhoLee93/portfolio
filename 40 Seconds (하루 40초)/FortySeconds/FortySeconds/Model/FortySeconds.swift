//
//  FortySeconds.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/12/22.
//

import Foundation

struct FortySeconds: Equatable {
    private var koreanBuffer = ["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하",
                                "갸", "냐", "댜", "랴", "먀", "뱌", "샤", "야", "쟈", "챠", "캬", "탸", "퍄", "햐",
                                "거", "너", "더", "러", "머", "버", "서", "어", "저", "처", "커", "터", "퍼", "허",
                                "겨", "녀", "뎌", "려", "며", "벼", "셔", "여", "져", "쳐", "켜", "텨", "펴", "혀",
                                "고", "노", "도", "로", "모", "보", "소", "오", "조", "초", "코", "토", "포", "호",
                                "교", "뇨", "됴", "료", "묘", "뵤", "쇼", "요", "죠", "쵸", "쿄", "툐", "표", "효",
                                "구", "누", "두", "루", "무", "부", "수", "우", "주", "추", "쿠", "투", "푸", "후",
                                "규", "뉴", "듀", "류", "뮤", "뷰", "슈", "유", "쥬", "츄", "큐", "튜", "퓨", "휴",
                                "그", "느", "드", "르", "므", "브", "스", "으", "즈", "츠", "크", "트", "프", "흐",
                                "기", "니", "디", "리", "미", "비", "시", "이", "지", "치", "키", "티", "피", "히"]
    
    private(set) var TYPE: String
    private(set) var WORD: String
    private(set) var DEFINITION: String
    
    private(set) var answer: String
    private(set) var answerBuffer: Array<Letter>
    private(set) var letterBuffer: Array<Letter>
    private(set) var stage = 1
    private(set) var isFinished: Bool
    private(set) var isSuccessful: Bool
    private(set) var shouldPrepare = false
    private(set) var wrongAnswer = false
    private(set) var rightAnswer = false
    private(set) var wordMatched = false

    
    private var bufferIdx = 0
    private var idNumber = 0

    
    init() {
        answer = ""
        WORD = ""
        TYPE = ""
        DEFINITION = ""
        answerBuffer = Array<Letter>()
        letterBuffer = Array<Letter>()
        isFinished = false
        isSuccessful = false
        shouldPrepare = false

        nextStage()
    }
    
    mutating func wrongAnswerToggle() {
        wrongAnswer.toggle()
    }
    
    mutating func prepToggle() {
        shouldPrepare.toggle()
    }
    
    mutating private func createEmpty() -> Letter {
        createLetter(of: "")
    }
    
    mutating func nextStage() {
        if stage < 6 {
            wordMatched = false
            shouldPrepare = false
            stage += 1
            prepare()
        }
    }
    
    mutating private func prepare() {
        if stage < 6 {
            setUp()
            bufferIdx = 0
            answer.removeAll()
            createAnswerBuffer()
            createLetterBuffer()
        } else {
            isSuccessful.toggle()
            isFinished.toggle()
        }
    }
    
    mutating private func setUp() {
        let rawString = WordBuffers(stage: stage).returnWord()
        let rawBuffer = rawString.components(separatedBy: ".")
        TYPE = rawBuffer[0]
        WORD = rawBuffer[1]
        DEFINITION = rawBuffer[2]
    }
    
    mutating private func createAnswerBuffer() {
        answerBuffer.removeAll()
        
        for _ in 0..<WORD.count {
            answerBuffer.append(createEmpty())
        }
    }
    
    mutating private func createLetterBuffer() {
        letterBuffer.removeAll()
        
        let size = stage * 3

        for idx in 0..<WORD.count {
            let bufferIndex = WORD.index(WORD.startIndex, offsetBy: idx)
            let str = String(WORD[bufferIndex])
            letterBuffer.append(createLetter(of: str))
        }
        
        while letterBuffer.count < size {
            let random = koreanBuffer.randomElement()!
            if !letterBuffer.contains(where: { $0.content == random }) {
                letterBuffer.append(createLetter(of: random))
            }
        }

        letterBuffer.shuffle()
    }
    
    mutating private func createLetter(of str: String) -> Letter {
        
        return Letter(content: str)
    }
    
    mutating func enter(in letter: Letter) {
        if answer.count < stage {
            answer += letter.content
            answerBuffer[bufferIdx].content = letter.content
            bufferIdx += 1
            
            if answer.count == stage {
                if isMatched() {
                    rightAnswer = true
                } else {
                    wrongAnswer = true
                }
            }
        }
    }
    
    mutating func ifRight() {
        wordMatchedToggle()
    }
    
    mutating func ifWrong() {
        answer.removeAll()
        for idx in 0..<answerBuffer.count {
            answerBuffer[idx].content = ""
        }
        bufferIdx = 0
    }
    
    mutating func rightAnswerToggle() {
        rightAnswer.toggle()
    }
    
    mutating func wordMatchedToggle() {
        wordMatched.toggle()
    }
    
    mutating func matchedToggle() {
        for idx in 0..<answerBuffer.count {
            answerBuffer[idx].isMatched.toggle()
        }
    }
    
    mutating func letterToggle(for letter: Letter) {
        if let idx = answerBuffer.firstIndex(where: { $0.id == letter.id }) {
            answerBuffer[idx].isMatched.toggle()
        }
    }
    
    mutating func backspace() {
        if answer.count > 0 {
            answer.removeLast()
            bufferIdx -= 1
            answerBuffer[bufferIdx].content = ""
        }
    }
    
    private func isMatched() -> Bool {
        if answer == WORD {
            
            return true
        }
        
        return false
    }
    
    struct Letter: Identifiable, Equatable {
        let id = UUID()
        var content: String
        var isMatched = false
    }

}
