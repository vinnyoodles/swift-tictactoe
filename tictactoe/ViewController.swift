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
    private var npc = Computer()
    private var recognizer: UITapGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     * Event listener every time a tile button is clicked.
     * This is the start of every game loop.
     */
    @IBAction func tileClick(_ tile: AnyObject) {
        // NOTE: the tag starts off with index 1.
        if !game.play(tile.tag - 1) {
            return
        }
        // Update the player's tile.
        if !updateTile(tile, 0), let compTile = self.view.viewWithTag(npc.move()) as? UIButton {
            game.set(compTile.tag - 1, 1)
            // If the game is still playable after the player's turn, then update the computer's tile.
            updateTile(compTile, 1)
        }
    }
    
    /**
     * Update the board tile and check the current state of the game.
     * @return true if the game is still playable, false otherwise.
     */
    func updateTile(_ tile: AnyObject, _ player: Int) -> Bool {
        // Grab the respective image and update the image view.
        let imageType = player == 1 ? "Circle" : "Cross"
        tile.setImage(UIImage(named: imageType), for: UIControlState())
        if game.isOver() {
            game.end()
            renderEndState()
            return false
        }
        return true
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

