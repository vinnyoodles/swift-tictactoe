//
//  ViewController.swift
//  tictactoe
//
//  Created by Vincent on 6/25/17.
//  Copyright © 2017 Vincent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var game = GameState()
    private var recognizer: UITapGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     * Event listener every time a tile button is clicked.
     */
    @IBAction func tileClick(_ tile: AnyObject) {
        // NOTE: the tag starts off with index 1
        if (!game.play(tile.tag - 1)) {
            return
        }
        
        updateTile(tile)
        if game.isOver() {
            game.end()
            renderEndState()
        }
    }
    
    func updateTile(_ tile: AnyObject) {
        // Grab the respective image and update the image view.
        let imageType = game.player == 1 ? "Circle" : "Cross"
        tile.setImage(UIImage(named: imageType), for: UIControlState())
    }
    
    func renderEndState() {
        messageLabel.isHidden = false
        // TODO: Enter post game message
        messageLabel.text = "\(game.state.rawValue)"
        scoreLabel.text = "Score: \(game.score)"
        
        recognizer = UITapGestureRecognizer(target: self, action: #selector(self.renderNewGame))
        if let _ = recognizer {
            self.view.addGestureRecognizer(recognizer!)
        }
        
        // Disable all the buttons.
        for i in 1...9 {
            let tile = self.view.viewWithTag(i) as! UIButton
            tile.isEnabled = false
        }
    }
    
    @objc func renderNewGame() {
        if let _ = recognizer {
            self.view.removeGestureRecognizer(recognizer!)
        }
        recognizer = nil
        messageLabel.isHidden = true
        game.restart()
        
        // Re-enable all the buttons and reset the image.
        for i in 1...9 {
            let tile = self.view.viewWithTag(i) as! UIButton
            tile.setImage(nil, for: UIControlState())
            tile.isEnabled = true
        }
        
    }
}

