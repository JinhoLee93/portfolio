//
//  ContentView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            MainView()
                .navigationTitle("Beatitudo Media")
        }
    }
}

#Preview {
    ContentView()
}
