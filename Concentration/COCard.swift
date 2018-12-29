//
//  Card.swift
//  Concentration
//
//  Created by Hanna Karnaukh on 5/13/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct COCard: Hashable {
    var isFaceUP = false
    var isMatched = false
    private var iD: Int
    
    var hashValue: Int {
        return iD
    }
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.iD = COCard.getUniqueIdentifier()
    }
    
    static func == (lhs: COCard, rhs: COCard) -> Bool {
        return lhs.iD == rhs.iD
    }
}
