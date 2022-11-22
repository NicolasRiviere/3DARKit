//
//  Transaction.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 15/02/2021.
//

import Foundation

typealias Amount = Double

struct Transaction: Identifiable {
    let id: Int
    let title: String
    let status: Status
    let amount: Amount
    let date: Date
}

extension Transaction {
    enum Status {
        case completed, error, pending
    }
}

extension Transaction {
    static func samples() -> [Transaction] {
        return [
            Transaction(id: UUID().hashValue, title: "Carrefour", status: .pending, amount: -15.50, date: Date()),
            Transaction(id: UUID().hashValue, title: "DELIVEROO", status: .pending, amount: -22.30, date: Date()),
            Transaction(id: UUID().hashValue, title: "EVI CSE Worldline", status: .completed, amount: 50.0, date: Date()),
            Transaction(id: UUID().hashValue, title: "SPAR", status: .completed, amount: -25.0, date: Date().addDays(-1)),
            Transaction(id: UUID().hashValue, title: "EVI SIACI SAINT HONORE", status: .completed, amount: 45.89, date: Date().addDays(-1)),
            Transaction(id: UUID().hashValue, title: "KEOLIS LYON", status: .error, amount: -128.0, date: Date().addDays(-2))
        ]
    }
}

extension Date {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd, HH:mm"
        dateFormatter.locale = Locale.appLocale

        return dateFormatter
    }()

    var textual: String {
        Self.dateFormatter.string(from: self)
    }

    /// Returns `true` if the date is today, false otherwise.
    var isToday: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .day) == .orderedSame
    }

    /// Returns `true` if the date is yesterday, false otherwise.
    var isYesterday: Bool {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return false }

        return Calendar.current.compare(self, to: yesterday, toGranularity: .day) == .orderedSame
    }
}

fileprivate extension Date {
    func addDays(_ interval: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: interval, to: self) ?? self
    }
}

extension Amount {
    static let currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.appLocale

        return numberFormatter
    }()

    var textual: String {
        Self.currencyFormatter.string(from: self as NSNumber) ?? ""
    }
}
