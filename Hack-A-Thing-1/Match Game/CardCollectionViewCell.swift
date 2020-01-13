//
//  CardCollectionViewCell.swift
//  Hack-A-Thing-1
//
//  Created by Jason Ceto on 1/13/20.
//  Copyright © 2020 Jason Ceto. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)

        // Display the correct image depending on card state
        
        if card.isMatched {
            backImageView.alpha = 0
            frontImageView.alpha = 0

            return
        } else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
                
        if card.isFlipped {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func reveal() {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func hide() {
        
        let seconds = 0.6
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
                        
        })
        
    }
    
    func remove() {
                
        backImageView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
    
}
