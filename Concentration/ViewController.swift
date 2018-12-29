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
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private var emojisThemes = [animalsTheme, yellowFacesTheme, flowersAndLeafs, moons, fruitsVegetables, vehicle, flags]
    private var emojiChoices: String = ""
    private var emojiOnCardId = [COCard: String]()
    private lazy var game = COConcentration(numberOfPairsOfCard: cardButtons.count / 2)
    private(set) var flipCount = 0 {
        didSet {
           updateFlipCountLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameOnStart()
    }
    
    func setGameOnStart() {
        updateViewFromModel()
        emojiChoices = emojisThemes[emojisThemes.count.arc4random]
        emojiOnCardId = [COCard: String]()
        game = COConcentration(numberOfPairsOfCard: cardButtons.count / 2)
        flipCount = 0
    }
    
    private func updateFlipCountLabel() {
        let attribets: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.orange]
        let attribetedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attribets)
        flipCountLabel.attributedText = attribetedString
    }
    
    @IBAction private func cardPressed(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        setGameOnStart()
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
        if emojiOnCardId[card] == nil, emojiChoices.count >= 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emojiOnCardId[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emojiOnCardId[card] ?? "?"
    }
}



