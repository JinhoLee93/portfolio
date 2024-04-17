//
//  DummyScreen.swift
//  FortySeconds
//
//  Created by Jinho Lee on 3/2/22.
//

import SwiftUI

struct DummyScreen: View {
    var body: some View {
        Spacer()
        Image("40secsLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
                UIApplication.shared.applicationIconBadgeNumber = 0
                NotificationManager.notification.requestAuthorization()
            }
        Spacer()
        VStack {
            Text("Created by Jinho Lee")
                .frame(alignment: .bottom)
                .font(.headline)
        }
    }
}
