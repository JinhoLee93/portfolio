//
//  EmailSigningAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/23/24.
//

import Foundation

class EmailSigningAPIServices {
    private let domain: NetworkLayer
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
//    func postNewUserWith(email: String, nickname: String) async {
//        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-new-user/"
//        let parameters: [String : Any] = ["email" : email,
//                                          "nickname": nickname]
//        await domain.post(url: url, parameters: parameters)
//    }
}
