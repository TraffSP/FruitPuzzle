//
//  AnalyticsService.swift
//  FruitPuzzle
//
//  Created by muser on 26.02.2025.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsService {
    static let shared = AnalyticsService()
    
    private init() {}

    func logScreenView(screenName: String) {
        Analytics.logEvent("screen_view", parameters: [
            "screen": screenName
        ])
    }
}
