//
//  Date.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 18.08.2022.
//

import Foundation

extension Double {
    var dateString: String {
        DateFormatter.dayFormat.string(from: Date(timeIntervalSince1970: self))
    }
}

extension DateFormatter {
    static var dayFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, MMM dd, yyyy HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        return formatter
    }
}
