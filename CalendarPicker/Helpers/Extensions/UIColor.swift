//
//  UIColor.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 27.03.2024.
//

import Foundation
import SwiftUI

extension UIColor {
    // Convert UIColor to a string representation
    var asString: String {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return "1,1,1,1" // Default to white if the color cannot be converted
        }

        let red = components[0]
        let green = components[1]
        let blue = components[2]
        let alpha = components.count >= 4 ? components[3] : 1.0 // Assume alpha is 1 if not specified
        return "\(red),\(green),\(blue),\(alpha)"
    }

    // Initialize UIColor from a string representation
    static func from(string: String) -> UIColor? {
        let components = string.split(separator: ",").compactMap { CGFloat(Double($0) ?? 0.0) }
        guard components.count == 4 else { return nil }
        return UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
    }
}
