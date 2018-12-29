//
//  Extensions.swift
//  Concentration
//
//  Created by Hanna Karnaukh on 10/23/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import Foundation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
