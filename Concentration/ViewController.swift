//
//  ViewController.swift
//  Concentration
//
//  Created by Hanna Karnaukh on 4/25/18.
//  Copyright © 2018 Hanna Karnaukh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    
    private var emojisThemes = [animalsTheme, yellowFacesTheme, flowersAndLeafs, moons, fruitsVegetables, vehicle, flags]
    private var emojiChoices = [String]()
    private var emojiOnCardId = [Int: String]()
    private lazy var game = COConcentration(numberOfPairsOfCard: cardButtons.count / 2)
    private(set) var flipCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set()
    }
    
    func set() {
        updateViewFromModel()
        emojiChoices = emojisThemes[Int(arc4random_uniform(UInt32(emojisThemes.count)))]
        emojiOnCardId = [Int: String]()
        game = COConcentration(numberOfPairsOfCard: cardButtons.count / 2)
    }
    
    @IBAction private func cardPressed(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        set()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUP {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: COCard) -> String {
        if emojiOnCardId[card.iD] == nil, emojiChoices.count >= 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiOnCardId[card.iD] = emojiChoices.remove(at: randomIndex)
        }
        return emojiOnCardId[card.iD ] ?? "?"
    }
}

