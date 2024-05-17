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
}
