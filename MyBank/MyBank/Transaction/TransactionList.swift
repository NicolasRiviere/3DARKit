//
//  TransactionList.swift
//  MyBank
//
//  Created by Nicolas RIVIERE on 01/04/2021.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var cardModel: CardModel
    @EnvironmentObject var transactionModel: TransactionModel
    @Binding var showCardDetail: Bool
    let cardViewNameSpace: Namespace.ID

    var body: some View {
        ZStack {
            BackgroundView()
                .frame(maxWidth: .leastNonzeroMagnitude)
                .zIndex(0)

            VStack {
                header
                    .zIndex(1)

                card
                    .zIndex(2)

                Spacer()
            }

            list
                .zIndex(3)
                .padding(.top, 270)
                .transition(.slide)
                .ignoresSafeArea(.container, edges: .bottom)
        }
        .navigationBarHidden(true)
        .onAppear {
            transactionModel.fetchTransactions()
            transactionModel.fetchAccountBalance()
        }
    }

    var header: some View {
        HStack {
            Text("Home")
                .font(.system(size: 22, weight: .bold, design: .rounded))

            Spacer()

            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .background(Color.white)
                .cornerRadius(15)
        }
        .padding(.horizontal)
    }

    var card: some View {
        HStack {
            CardView(amount: transactionModel.balance)
                .environmentObject(cardModel)
                .onTapGesture {
                    withAnimation(.easeInOut) { showCardDetail = true }
                }
                .matchedGeometryEffect(
                    id: "CardView",
                    in: cardViewNameSpace,
                    properties: .position,
                    anchor: .center,
                    isSource: true
                )
        }
        .padding()
    }

    var list: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Section(header: sectionHeaderView(title: "Today")) {
                    ForEach(transactionModel.transactions.filter({ $0.date.isToday })) { transaction in
                        TransactionView(transaction: transaction)
                        SeparatorView()
                    }
                    .padding(.leading, 8)
                }

                Section(header: sectionHeaderView(title: "Yesterday")) {
                    ForEach(transactionModel.transactions.filter({ $0.date.isYesterday })) { transaction in
                        TransactionView(transaction: transaction)
                        SeparatorView()
                    }
                    .padding(.leading, 8)
                }

                Section(header: sectionHeaderView(title: "Earlier this month")) {
                    ForEach(transactionModel.transactions.filter({ !$0.date.isToday && !$0.date.isYesterday })) { transaction in
                        TransactionView(transaction: transaction)
                        SeparatorView()
                    }
                    .padding(.leading, 8)
                }
            }
        }
        .disabled(true)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 8)
    }

    func sectionHeaderView(title: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(Color.black)
                .font(.system(size: 17, weight: .bold, design: .rounded))

            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 24, bottom: 8, trailing: 0))
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList(
            showCardDetail: .constant(false),
            cardViewNameSpace: Namespace().wrappedValue
        )
        .environmentObject(TransactionModel())
        .environmentObject(CardModel())
    }
}

