//
//  Card.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 16/02/2021.
//

import Foundation

struct Card: Identifiable {
    let id: Int
    let holderFirstName: String
    let holderLastName: String
    let scheme: Scheme
    let number: String
    let expirationDate: Date
    let cardValidationValue: String
}

extension Card {
    enum Scheme {
        case visa
    }

    enum Rank {
        case visa
        case gold
        case cocoa
    }
}

extension Card {
    var firstFourDigits: String {
        String(number.split(maxSplits: 4, omittingEmptySubsequences: true, whereSeparator: { $0 == " " }).first ?? "")
    }

    var secondFourDigits: String {
        String(number.split(maxSplits: 4, omittingEmptySubsequences: true, whereSeparator: { $0 == " " })[1])
    }

    var thirdFourDigits: String {
        String(number.split(maxSplits: 4, omittingEmptySubsequences: true, whereSeparator: { $0 == " " })[2])
    }

    var lastFourDigits: String {
        String(number.split(maxSplits: 4, omittingEmptySubsequences: true, whereSeparator: { $0 == " " }).last ?? "")
    }

    var expirationDateFormattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YYYY"

        return dateFormatter.string(from: expirationDate)
    }

    var holderCompleteName: String {
        "\(holderFirstName) \(holderLastName)"
    }
}

extension Card {
    static func sample() -> Card {
        Card(
            id: 0,
            holderFirstName: "Jean",
            holderLastName: "Dupont",
            scheme: .visa,
            number: "5412 5689 1487 5610",
            expirationDate: Date(timeIntervalSince1970: 1686614400),
            cardValidationValue: "577"
        )
    }

    static func upgraded() -> Card {
        Card(
            id: 0,
            holderFirstName: "Jean",
            holderLastName: "Dupont",
            scheme: .visa,
            number: "5412 5689 1452 4589",
            expirationDate: Date(timeIntervalSince1970: 1719918400),
            cardValidationValue: "328"
        )
    }
}
