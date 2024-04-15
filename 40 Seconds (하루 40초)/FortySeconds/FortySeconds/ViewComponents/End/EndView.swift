//
//  EndView.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/27/22.
//

import SwiftUI

struct EndView: View {
    let isSuccessful: Bool
    let restart: () -> Void
   
    @ObservedObject private(set) var backgroundClock = BackgroundClock()
    @AppStorage("restartUp") var restartUp = false
    @AppStorage("scheduled") var scheduled = false

    var body: some View {
        VStack {
            isSuccessful ?  Text("축하드려요! 다 맞추셨어요🥳 내일 또 만나요!").font(.headline) :
                            Text("시간이 다 됐어요😭 내일 또 만나요!").font(.headline)
            
            Text(backgroundClock.message)
                .font(.headline)
                .opacity(restartUp ? 0:1)
                .onAppear {
                    if !scheduled {
                        NotificationManager.notification.scheduleNotification()
                    }
                    scheduled = true
                    restartUp = false
                }
            
            if !backgroundClock.isRunning {
                ZStack {
                    let rectangle = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    rectangle.fill().foregroundColor(.white)
                    rectangle.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text("새로운 게임하기")
                        .foregroundColor(.black)
                        .font(.headline)
                }
                .frame(width: DrawingConstants.frameWidth, height: DrawingConstants.frameHeight)
                .opacity(restartUp ? 1:0)
                .onTapGesture {
                    restart()
                    backgroundClock.stop()
                    UIApplication.shared.applicationIconBadgeNumber = 0
                    restartUp = false
                    scheduled = false
                }
                .onAppear {
                    restartUp = true
                }
            }
        }
    }
    
    struct DrawingConstants {
        static let lineWidth: CGFloat = 4.5
        static let cornerRadius: CGFloat = 20
        static let frameWidth: CGFloat = 120
        static let frameHeight: CGFloat = 50
    }
}
