//
//  GameView.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/6/22.
//

import SwiftUI

struct GameView: View {
    @Binding var gameViewIn: Bool
    @ObservedObject var model: CoreDataVM
    
    @State private var offset = CGSize.zero
    @State private var lastDragPosition: DragGesture.Value?
    @FocusState private var keyboardUp: FocusField?
    let maxWidth = UIScreen.main.bounds.width
    
    @State var everythingIn = false

    var body: some View {
        ZStack {
            Color.gameColor
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    clockBody
                }
                .frame(alignment: .center)
                VStack {
                    answerBody
                        .padding(.bottom, 90)
                    descriptionBody
                    Spacer()
                }
                .frame(alignment: .center)
                Spacer()
            }
            .onAppear {
                everythingIn = true
            }
            .opacity(everythingIn ? 1 : 0)
        }
        .offset(x: self.offset.width, y: 0) 
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.keyboardUp = .none
                    self.offset = CGFloat(value.translation.width) > 0 ? value.translation:.zero
                    self.lastDragPosition = value
                }
                .onEnded { value in
                    let timeDiff = value.time.timeIntervalSince(self.lastDragPosition!.time)
                    let speed:CGFloat = CGFloat(value.translation.width - self.lastDragPosition!.translation.width) / timeDiff
                    
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if offset.width > (maxWidth * 0.8)  || (speed > 200 && offset.width > 0) {
                            offset.width = maxWidth
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                gameViewIn.toggle()
                                model.reset()
                            }
                        } else {
                            offset = .zero
                        }
                    }
                }
        )
        .gesture(TapGesture(count: 2)
            .onEnded(
            {
                if model.currentNote!.isMemorized && everythingIn {
                    model.nextStage()
                    resetClock()
                }
            })
            .exclusively(before:
                TapGesture()
                .onEnded(
                {
                    self.keyboardUp = .none
                }))
        )
        .onChange(of: model.gameOver) { _ in
            everythingIn = false
            if model.gameOver {
                withAnimation {
                    gameViewInToggleWhenEnded()
                }
                model.reset()
            }
        }
        .onChange(of: everythingIn) { _ in
            keyboardUp = everythingIn ? .field : .none
        }
        .zIndex(1)
    }
    
    struct GameConstants {
        static let backPadding: CGFloat = 17.5
        static let clockPadding: CGFloat = 11
        static let skipPadding: CGFloat = 14.5
        static let answerHeight: CGFloat = 150
    }
    
    func gameViewInToggleWhenEnded() {
        self.keyboardUp = .none
        withAnimation(.easeInOut(duration: 0.1)) {
            gameViewIn.toggle()
        }
    }
    
    /* Clock Starts */
    @State private(set) var timeRemaining = ClockConstants.timeAllowed
    @State private var scale = ClockConstants.scale
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var clockBody: some View {
        Text("\(timeRemaining)")
            .font(font(ClockConstants.fontSize))
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    self.keyboardUp = .none
                    doAnimation {
                        gameViewIn.toggle()
                        model.reset()
                    }
                }
            }
            .foregroundColor(.textColor)
            .scaleEffect(scale)
            .onAppear {
                let repeated =
                    Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    scale = ClockConstants.scaleChanged
                }
            }
    }
    
    private func resetClock() {
        timeRemaining = ClockConstants.timeAllowed
    }

    private struct ClockConstants {
        static let fontSize: CGFloat = 50
        static let timeAllowed: Int = 10
        static let scale: CGFloat = 1
        static let scaleChanged: CGFloat = 0.8
    }
    /* Clock Ends */
    
    /* Answer Starts */
    @State var word = ""
    @State var isWrong = false
    
    var answerBody: some View {
        VStack {
            TextField("Answer", text: $word)
                .focused($keyboardUp, equals: .field)
                .onAppear {
                    self.keyboardUp = .field
                }
                .onTapGesture {
                    self.keyboardUp = .field
                }
                .shake(isWrong ? 0 : 1)
                .onSubmit {
                    withAnimation {
                        if word.lowercased() == model.currentNote!.word!.lowercased() {
                            everythingIn = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    model.nextStage()
                                    resetClock()
                                    word = ""
                                    everythingIn = true
                                }
                            }
                        } else {
                            isWrong.toggle()
                            UIDevice.vibrate()
                        }
                    }
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .foregroundColor(.textColor)
        }
    }
    
    var descriptionBody: some View {
        Text("[\(model.currentNote!.type!)] \(model.currentNote!.definition!)")
            .font(font(AnswerConstants.fontSize))
            .foregroundColor(.textColor)
    }
    
    private struct AnswerConstants {
        static let fontSize: CGFloat = 25
        static let height: CGFloat = 60
    }
    /* Answer Ends */
    
    private func font(_ constant: CGFloat) -> Font {
        Font.system(size: constant)
    }
}

extension GameView {
    enum FocusField: Hashable {
        case field
    }
    
    private func doAnimation(of action: () -> Void) {
        withAnimation(.easeInOut(duration: 0.1)) {
            action()
        }
    }
}
