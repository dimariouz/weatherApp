//
//  Dictionary.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 27.02.2023.
//

import Foundation

extension Dictionary {
    func merge(_ dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var mutableCopy = self
        for (key, value) in dict {
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}
