//
//  UIDevice.swift
//  WordsADay
//
//  Created by Jinho Lee on 3/8/22.
//

import SwiftUI
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
}
