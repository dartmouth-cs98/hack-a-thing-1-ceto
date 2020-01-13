//
//  WarViewController.swift
//  Hack-A-Thing-1
//
//  Created by Jason Ceto on 1/13/20.
//  Copyright © 2020 Jason Ceto. All rights reserved.
//

import UIKit

class WarViewController: UIViewController {
    
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftScoreLabel: UILabel!
    
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    var playerScore = 0
    var compScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "War Game View"
                
    }
    
    @IBAction func dealButtonTapped(_ sender: Any) {
                
        // grab a random integer for drawing cards (can be improved)
        let leftNum = Int.random(in: 2...14)
        let rightNum = Int.random(in:2...14)
        
        // update card images
        leftImageView.image = UIImage(named: "card\(leftNum)")
        rightImageView.image = UIImage(named: "card\(rightNum)")
        
        
        // score round
        if leftNum > rightNum {
            
            // player wins
            playerScore += 1
            
            leftScoreLabel.text = String(playerScore)
        
        } else if rightNum > leftNum {
            
            // comp wins
            compScore += 1
            
            rightScoreLabel.text = String(compScore)
        }
    }
    
}

