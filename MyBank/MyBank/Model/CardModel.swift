//
//  CardModel.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 15/02/2021.
//

import Foundation

class CardModel: NSObject, ObservableObject {
    @Published var userCard: Card?
}

extension CardModel {
    func fetchCardData() {
        guard userCard == nil else { return }

        userCard = Card.sample()
    }

    func upgrade() {
        userCard = Card.upgraded()
    }
}
