//
//  Locale+extension.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 18/02/2021.
//

import Foundation

extension Locale {
    static var appLocale: Locale {
        guard let languageCode = Locale.preferredLanguages.first ?? Locale.current.languageCode, let regionCode = Locale.current.regionCode
        else {
            return Locale.current
        }

        return Locale(identifier: "\(languageCode)_\(regionCode)")
    }
}
