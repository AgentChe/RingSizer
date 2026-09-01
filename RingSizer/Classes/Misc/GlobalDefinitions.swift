//
//  GlobalDefinitions.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import Foundation

final class GlobalDefinitions {
    static let domain = "https://wallpapers.thinkaboutapps.com"
    static let apiKey = "oGHM7Q0EGjH0kUYtT2TT"
    
    static let otterScaleHost = "https://api.korrekted.com"
    static let otterScaleApiKey = "IHAQkAwwuZK9IjP1"

    static let applicationTag = "RING_SIZER"
    static let postHogHost = "https://posthog.korrekted.com"
    static let postHogApiKey = "phc_a29Kj3MGr3nLv9NN4WLZiRyHF5mluQZaPbVgcCbIqPa"
    
    static let termsOfServiceUrl = URL(string: "https://thinkaboutapps.com/terms")!
    static let privacyPolicyUrl = URL(string: "https://thinkaboutapps.com/policy")!
    static let contactUsUrl = URL(string: "https://thinkaboutapps.com/contact")!
    
    enum Paygate {
        static let yearly = "app.ringsizer.yearly2"
        static let weekly = "app.ringsizer.weekly"
    }
}
