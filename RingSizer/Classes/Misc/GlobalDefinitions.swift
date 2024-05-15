//
//  GlobalDefinitions.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import Foundation

final class GlobalDefinitions {
    static let domain = "wallpapers.maria-apps.com"
    static let apiKey = "oGHM7Q0EGjH0kUYtT2TT"
    
    static let otterScaleHost = "https://api.korrekted.com"
    static let otterScaleApiKey = "IHAQkAwwuZK9IjP1"
    
    static let applicationTag = "RING_SIZER"
    static let amplitudeApiKey = "d433d2c66723aeefd10c5b65f91c1fa3"
    
    static let termsOfUseUrl = URL(string: "https://maria-apps.com/terms")!
    static let privacyPolicyUrl = URL(string: "https://maria-apps.com/policy")!
    static let contactUsUrl = URL(string: "https://maria-apps.com/contact")!
    
    enum Paygate {
        static let monthly = "app.ringsizer.monthly"
        static let yearly = "app.ringsizer.yearly"
    }
}
