//
//  Task.swift
//  FortySeconds
//
//  Created by Jinho Lee on 4/2/23.
//

extension Task where Success == Never, Failure == Never {
    static func sleep(for seconds: Double) async throws {
        let nano: Double = 1_000_000_000
        let durationInNano = UInt64(seconds * nano)
        try await Task.sleep(nanoseconds: durationInNano)
    }
}
