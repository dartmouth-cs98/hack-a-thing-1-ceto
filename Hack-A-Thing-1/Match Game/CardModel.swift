//
//  CardModel.swift
//  Hack-A-Thing-1
//
//  Created by Jason Ceto on 1/13/20.
//  Copyright © 2020 Jason Ceto. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // Declare an array to store generated cards
        var cardArray = [Card]()
        var valSet = Set<Int>()
        
        // Generates 8 pairs of cards (16 Total)
        while cardArray.count < 16 {
            
            let randInt = Int.random(in:101...113)
            
            if !valSet.contains(randInt) {
                
                valSet.insert(randInt)
                
                // Create and append the card
                let currCard = Card()
                currCard.imageName =  "card\(randInt)"
                cardArray.append(currCard)
                
                // Create and append the corresponding pair
                let pairCard = Card()
                pairCard.imageName = "card\(randInt)"
                cardArray.append(pairCard)
                
            }
            
        }
        
        // Randomize array so pairs are not together
        
        for i in 0...(cardArray.count-1) {
            let randNum = Int.random(in:0...(cardArray.count - 1))
            
            let tempStorage = cardArray[i]
            
            cardArray[i] = cardArray[randNum]
            cardArray[randNum] = tempStorage
        }
        
        
        // Return Array
        return cardArray
        
    }
}
