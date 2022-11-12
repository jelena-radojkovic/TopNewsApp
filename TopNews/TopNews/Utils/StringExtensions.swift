//
//  StringExtensions.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 12.11.22..
//

import Foundation

extension String {
    func toDate()-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from: components)
        
        guard let finalDate = finalDate else {
            print("Error while converting date: \(self)")
            return Date()
        }

        return finalDate
    }
}
