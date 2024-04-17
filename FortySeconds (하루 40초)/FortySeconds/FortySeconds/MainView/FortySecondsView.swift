//
//  ContentView.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/12/22.
//

import SwiftUI

struct FortySecondsView: View {
    @ObservedObject var game: FortySecondsGame // ViewModel
    @Namespace private var arrangingNamespace
    
    @State var descriptionIn = false
    @State var splashIn = false
    @State var viewIn = false
    
    @AppStorage("timeUp") var timeUp = false
    @AppStorage("isFinished") var isFinished = false
    @AppStorage("notificationAsked") var notificationAsked = false
    @AppStorage("isSuccessful") var isSuccessful = false

    @State private var arranged = Set<UUID>()

    var body: some View {
        if !splashIn {
            if !notificationAsked {
                DummyScreen()
                    .onChange(of: NotificationManager.notification.notificationAsked) { _ in
                        notificationAsked.toggle()
                    }
            } else {
                SplashScreen()
                    .opacity(splashIn ? 0:1)
                    .onAppear {
                        Task {
                            await prepSplashArt()
                        }
                    }
            }
        } else {
            if !isFinished && !timeUp {
                clockBody
                VStack {
                    Spacer()
                    answerBody
                        .shake(game.wrongAnswer ? 1:0)
                        .onChange(of: game.wrongAnswer) { _ in
                            if game.wrongAnswer {
                                UIDevice.vibrate()
                                withAnimation {
                                    game.wrongAnswerToggle()
                                }
                            }
                        }
                        .onChange(of: game.isFinished) { _ in
                            isFinished.toggle()
                        }
                    ZStack {
                        descriptionBody
                        containerBody
                    }
                    Spacer()
                }
                .frame(height: 170)
                VStack {
                    picksBody
                    backspace
                    Spacer()
                }
                .onChange(of: game.isSuccessful) { _ in
                    isSuccessful = game.isSuccessful
                }
            } else {
                EndView(isSuccessful: isSuccessful, restart: restart)
                    .transition(.slide)
            }
        }
    }
    
    @State private(set) var timeRemaining = TimeConstants.timeRemaining
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var stop = false
    @State var underTenSec = false
    @State var scale: CGFloat = 1

    var clockBody: some View {
        timeConverter(counter: timeRemaining)
            .scaleEffect(scale)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 0.01
                    if timeRemaining < 10 {
                        withAnimation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true)) {
                            scale = 0.8
                        }
                    }
                } else {
                    timer.upstream.connect().cancel()
                    timeUp.toggle()
                }
            }
            .opacity(viewIn ? 1:0)
            .onChange(of: stop) { _ in
                if stop {
                    timer.upstream.connect().cancel()
                } else {
                    timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
                }
            }
    }
    
    var answerBody: some View {
        HStack {
            ForEach(game.answerBuffer) { letter in
                if isUnarranged(letter) {
                    Color.clear
                } else {
                    AnswerSquare(letter: letter, isMatched: letter.isMatched, answerBuffer: game.answerBuffer)
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .matchedGeometryEffect(id: letter.id, in: arrangingNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
            }
        }
        .onChange(of: game.wordMatched) { _ in
            if game.wordMatched {
                withAnimation {
                    for letter in game.answerBuffer {
                        game.letterToggle(for: letter)
                    }
                }
                Task {
                    await prepNextStage()
                }
            }
        }
        .onChange(of: game.rightAnswer) { _ in
            if game.rightAnswer {
                Task {
                    await prepReactionToRightAnswer()
                }
            }
        }
        .onChange(of: game.wrongAnswer) { _ in
            if game.wrongAnswer {
                Task {
                    await prepReactionToWrongAnswer()
                }
            }
        }
    }

    var descriptionBody: some View {
        Text("[\(game.type)] \(game.definition)")
            .font(.title)
            .minimumScaleFactor(0.5)
            .opacity(descriptionIn ? 1:0)
    }
    
    var picksBody: some View {
        AspectVGrid(items: game.letterBuffer, aspectRatio: DrawingConstants.aspectRatio, content: { letter in
            if isUnarranged(letter) {
                Color.clear
            } else {
                PickView(letter: letter, enter: {
                    game.enter(in: letter)
                })
                    .matchedGeometryEffect(id: letter.id, in: arrangingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .font(Font.system(size: DrawingConstants.fontSize))
            }
        })
    }
    
    var backspace: some View {
        Button (action: {
            game.backspace()
        })
        {
            Image(systemName: "delete.backward")
                .foregroundColor(.black)
                .font(Font.system(size: DrawingConstants.backSpaceSize))
        }
        .opacity(viewIn ? 1:0)
    }
    
    var containerBody: some View {
        ZStack {
            ForEach(game.answerBuffer) { letter in
                AnswerSquare(letter: letter, isMatched: letter.isMatched, answerBuffer: game.answerBuffer)
                    .matchedGeometryEffect(id: letter.id, in: arrangingNamespace)
                    .transition(.asymmetric(insertion: .scale, removal: .identity))
            }
            
            ForEach(game.letterBuffer) { letter in
                SquareView(letter: letter)
                    .matchedGeometryEffect(id: letter.id, in: arrangingNamespace)
                    .transition(.asymmetric(insertion: .scale, removal: .identity))
            }
        }
        .frame(width: SquareView.DrawingConstants.frameWidth,
               height: SquareView.DrawingConstants.frameHeight)
        .onChange(of: game.shouldPrepare) { _ in
            if game.shouldPrepare {
                withAnimation(arrangeAnimation()) {
                    arrange()
                    descriptionIn.toggle()
                }
            } else {
                withAnimation(arrangeAnimation()) {
                    arranged.removeAll()
                }
            }
        }
        .onChange(of: game.stage) { _ in
            descriptionIn.toggle()
            withAnimation {
                game.prepToggle()
            }
        }
        .onAppear {
            withAnimation {
                viewIn.toggle()
                game.prepToggle()
            }
        }
    }
}

extension FortySecondsView {
    @MainActor
    private func prepNextStage() async {
        self.stop.toggle()
        try? await Task.sleep(for: 0.8)
        game.nextStage()
        self.stop.toggle()
    }
    
    @MainActor
    private func prepReactionToRightAnswer() async {
        try? await Task.sleep(for: 0.1)
        game.ifRight()
        game.rightAnswerToggle()
    }
    
    @MainActor
    private func prepReactionToWrongAnswer() async {
        try? await Task.sleep(for: 0.1)
        game.ifWrong()
    }
    
    @MainActor
    private func prepSplashArt() async {
        try? await Task.sleep(for: 0.5)
        withAnimation(.easeInOut(duration: 0.3)) {
            splashIn = true
        }
    }
}

extension FortySecondsView {
    private func restart() {
        game.restart()
        timeRemaining = TimeConstants.timeRemaining
        timeUp = false
        descriptionIn = false
        viewIn = false
        isFinished = false
        isSuccessful = false
        scale = 1
    }
    
    private func arrange() {
        for letter in game.answerBuffer {
            arranged.insert(letter.id)
        }
        
        for letter in game.letterBuffer {
            arranged.insert(letter.id)
        }
    }
    
    private func isUnarranged(_ letter: FortySeconds.Letter) -> Bool {
        !arranged.contains(letter.id)
    }
    
    private func arrangeAnimation() -> Animation {
        Animation.easeInOut(duration: 0.5)
    }
    
    private func timeConverter(counter: Double) -> Text {
        let sec = Int(counter) % 60

        return Text(String(format: "0:%02i", sec)).font(.largeTitle)
    }
    
    private func turnAnimation(for letter: FortySeconds.Letter) -> Animation {
        var delay = 0.0
        if let index = game.answerBuffer.firstIndex(where: { $0.id == letter.id }) {
            delay = Double(index) * (0.6 / Double(game.answerBuffer.count))
        }
        
        return Animation.easeInOut(duration: 0.3).delay(delay)
    }
    
    struct TimeConstants {
        static let timeRemaining: Double = 40
    }
    
    struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let fontSize: CGFloat = 25
        static let backSpaceSize: CGFloat = 40
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = FortySecondsGame()
        
        FortySecondsView(game: game)
    }
}
