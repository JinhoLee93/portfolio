//
//  UIDevice.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/28/22.
//

import SwiftUI
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
}
