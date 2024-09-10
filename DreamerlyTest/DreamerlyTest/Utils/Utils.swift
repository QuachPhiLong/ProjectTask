//
//  Utils.swift
//  DreamerlyTest
//
//  Created by Long Quách on 10/09/2024.
//

import UIKit
import SwiftUITooltip

struct Utils {
    
    private init() {}
    
    static var hapticFeedbackGenerator: UINotificationFeedbackGenerator? {
        return UINotificationFeedbackGenerator()
    }
    
    static var appTooltipConfig: DefaultTooltipConfig{
        var tooltipConfig = DefaultTooltipConfig()
        tooltipConfig.enableAnimation = true
        tooltipConfig.animationOffset = 10
        tooltipConfig.animationTime = 0.5
        tooltipConfig.borderWidth = 2
        tooltipConfig.borderColor = Assets.orangeColor.swiftUIColor
        return tooltipConfig
    }
    
}
