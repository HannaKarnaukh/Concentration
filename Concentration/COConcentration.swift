//
//  COConcentration.swift
//  Concentration
//
//  Created by Hanna Karnaukh on 5/13/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation


class COConcentration {
    private(set) var cards = [COCard]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return faceUpCardIndies = cards.indices.filter { cards[$0].isFaceUP }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUP = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
         assert(numberOfPairsOfCard > 0, "Concentrations.numberOfPairsOfCard(at: \(numberOfPairsOfCard): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCard {
            let card = COCard()
            cards += [card, card]
        }
        var shuffledCards = [COCard]()
        for _ in 1...cards.count {
            shuffledCards.append(cards.remove(at: cards.count.arc4random))
        }
        cards = shuffledCards
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentrations.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                if cards[matchedIndex] == cards[index] {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUP = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
