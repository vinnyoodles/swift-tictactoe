//
//  GameState.swift
//  tictactoe
//
//  Created by Vincent on 6/26/17.
//  Copyright © 2017 Vincent. All rights reserved.
//

enum State: String {
    case Progress
    case Lost
    case Tied
    case Won // Should never happen.
}

class GameState {
    
    public private(set) var score: Int
    public private(set) var state: State // The current playing state of the game.
    private var board: [Int] // The current state of the board.
    private let winningCombo: [[Int]] // The 8 possible winning combinations.
    
    init() {
        self.score = 0
        self.board = [ -1, -1, -1, -1, -1, -1, -1, -1, -1 ]
        self.winningCombo =  [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        self.state = State.Progress
    }
    
    func play(_ index: Int) -> Bool {
        // Only allow clicks on unselected/unvisited tiles.
        // Also, only allow clicks if the game is active.
        // The player is able to make the move if all of the following are true.
        // 1. The board spot is empty
        // 2. The game is currently being played
        if board[index] >= 0 && state == State.Progress {
            return false
        }
        
        // Update the board
        set(index, 0)
        return true
    }
    
    func restart() {
        board = [ -1, -1, -1, -1, -1, -1, -1, -1, -1 ]
        state = State.Progress
    }
    
    func end() {
        score += 1
        if isStalemate() {
            state = State.Tied
        } else {
            // The player should never be able to win.
            state = State.Lost
        }
    }
    
    /**
     * Update the board state.
     * @param index - the index of the tile.
     * @param player - the player choosing the tile.
     */
    func set(_ index: Int, _ player: Int) {
        board[index] = player
    }

    func isOver() -> Bool {
        return didPlayerWin() || isStalemate()
    }
    
    /**
     * Check if the current board state is a valid win for the given player.
     * @return {Boolean} true if the player won, false otherwise.
     */
    func didPlayerWin() -> Bool {
        for combo in winningCombo {
            let i = combo[0]
            let j = combo[1]
            let k = combo[2]
            if board[i] >= 0 && board[i] == board[j] && board[j] == board[k] {
                return true
            }
        }
        return false
    }
    
    /**
     * Check if the current board state is full.
     * @return {Boolean} true if the board is full with no room for any more moves, false otherwise.
     */
    func isStalemate() -> Bool {
        for i in board {
            if i == -1 {
                return false
            }
        }
        
        return true
    }
}
