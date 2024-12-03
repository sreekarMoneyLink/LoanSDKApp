//
//  DateExtension.swift
//  InstaCard
//
//  Created by Ravindra on 30/10/24.
//

import Foundation

extension Date {
    func toUTC() -> Date {
        let timeZoneOffset = TimeZone.current.secondsFromGMT(for: self)
        return self.addingTimeInterval(TimeInterval(-timeZoneOffset))
    }
}
