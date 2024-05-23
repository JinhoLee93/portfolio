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
                    let currentUser: BeatitudoMediaUser = try await APIServices.shared.post(url: "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-new-user/", parameters: ["email" : "molkop@naver.com", "nickname" : "jinho Lee"])
                    
                    print(currentUser)
                } catch {
                    
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
