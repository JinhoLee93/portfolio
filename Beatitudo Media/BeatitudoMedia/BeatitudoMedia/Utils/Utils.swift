//
//  Utils.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/17/24.
//

import Foundation
import UIKit

final class Utils {
    static func getiOSVersion() -> String {
        
        return UIDevice.current.systemVersion
    }
    
    static func getAppVersion() -> String? {
        
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static func getAndClassifyCurrentHour() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 18..<24:
            return "기분 좋은 밤이에요."
        case 0..<7:
            return "선선한 새벽이에요."
        case 7..<12:
            return "좋은 아침이에요."
        case 12..<18:
            return "기운 넘치는 하루 되세요."
        default:
            return ""
        }
    }
}
