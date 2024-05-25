//
//  Test.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/23/24.
//

import SwiftUI

struct Test: View {
    var body: some View {
        
        Button {
            Task {
                do {
                    let currentUser: BeatitudoMediaUserWrapper = try await APIServices.shared.post(url: "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-user/", parameters: ["email" : "molkop@naver.com", "nickname" : "Jinho Lee"])
                    
                    print("asdasdasd")
                    print(currentUser)
                } catch {
                    print("\(error)")
                }
            }
        } label: {
            Text("tap")
        }
    }
}

#Preview {
    Test()
}
