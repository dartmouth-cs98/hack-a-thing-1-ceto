//
//  MatchViewController.swift
//  Hack-A-Thing-1
//
//  Created by Jason Ceto on 1/13/20.
//  Copyright © 2020 Jason Ceto. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var matchModel = CardModel()
    var cardArray = [Card]()
    
    // Track the first card that was flipped
    var revealedCardIndex:IndexPath?
    
    // Hold timer object for win condition (done in milliseconds)
    var timer:Timer?
    var milliseconds:Float = 90 * 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Match Game View"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = matchModel.getCards()
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timeElapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    // Universal for showing alerts
    func showAlert(_ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Make sure there is time left
        if milliseconds <= 0 {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if !card.isFlipped && !card.isMatched{
            
            cell.reveal()
            card.isFlipped = true
            
            // Checking for a match
            if revealedCardIndex == nil {
                
                revealedCardIndex = indexPath
                
            } else {
                
                checkForMatches(indexPath)
                
            }
        }
        
        // Flip Card
        card.isFlipped = false
        
    }
    
    // MARK: - Game Logic Methods
    
    func checkForMatches (_ testCardIndex:IndexPath) {
        
        let cardOneCell = collectionView.cellForItem(at: revealedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: testCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[revealedCardIndex!.row]
        let cardTwo = cardArray[testCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            victoryCheck()
            
        } else {
            
            cardOneCell?.hide()
            cardOne.isFlipped = false
            
            cardTwoCell?.hide()
            cardTwo.isFlipped = false
            
        }
        
        // Need collection view to reload cell of the first card if it is nil to delete properly
        if cardOneCell == nil {
            collectionView.reloadItems(at: [revealedCardIndex!])
        }
        
        revealedCardIndex = nil
        
    }
    
    func victoryCheck() {
        
        var isWon = true
        var title = ""
        var message = ""
        
        for card in cardArray {
            
            if !card.isMatched {
                isWon = false
                break
            }
        }
        
        if isWon {
            
            if milliseconds > 0 {
                timer?.invalidate()
                
                title = "Congratulations!"
                message = "You've Won"
            }
        } else {
            
            if milliseconds > 0 {
                return
            } else {
                
                title = "Game Over"
                message = "You've Lost"
                
            }
        }
        
        // Show Results in Alert
        showAlert(title, message)
        
    }
    
    // MARK: - Timer Methods
    
    @objc func timeElapsed() {
        milliseconds -= 1
        
        if milliseconds <= 0 {
            
            timer?.invalidate()
            timerLabel.textColor = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 0.9)
            victoryCheck()
            
        } else {
            
            // Convert to Seconds
            let timeRemaining = String(format: "%.2f", milliseconds/1000)
            
            timerLabel.text = "Time Remaining: \(timeRemaining)"
            
        }
    }
    
}

