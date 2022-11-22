//
//  TransactionModel.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 15/02/2021.
//

import Foundation

class TransactionModel: NSObject, ObservableObject {
    @Published private(set) var transactions: [Transaction] = []
    @Published private(set) var balance: Amount = 0.0
}

extension TransactionModel {
    func fetchTransactions() {
        transactions = Transaction.samples()
    }

    func fetchAccountBalance() {
        balance = 2156.54
    }
}
