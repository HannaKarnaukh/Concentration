//
//  COConcentration.swift
//  Concentration
//
//  Created by Hanna Karnaukh on 5/13/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation


class COConcentration {
    var cards = [COCard]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundInex: Int?
            for index in cards.indices {
                if cards[index].isFaceUP {
                    if foundInex == nil {
                        foundInex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundInex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUP = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
        for _ in 1...numberOfPairsOfCard {
            let card = COCard()
            cards += [card, card]
        }
        var shuffledCards = [COCard]()
        for _ in 1...cards.count {
            let randomNumber = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards.remove(at: randomNumber))
        }
        cards = shuffledCards
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                if cards[matchedIndex].iD == cards[index].iD {
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
