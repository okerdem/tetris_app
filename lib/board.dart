import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/piece.dart';
import 'package:flutter_tetris_app/pixel.dart';
import 'package:flutter_tetris_app/values.dart';

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  columnLenght,
  (i) => List.generate(
    rowLenght,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.S);
  int currentScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // start game
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    // fps
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear lines
        clearLines();

        // check landing
        checkLanding();

        // check if game is over
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }

        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // game over message
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your score is: $currentScore"),
        actions: [
          TextButton(
              onPressed: () {
                // reset the game

                resetGame();

                Navigator.pop(context);
              },
              child: Text("Play Again"))
        ],
      ),
    );
  }

  // reset game
  void resetGame() {
    // clear the board
    gameBoard = List.generate(
      columnLenght,
      (i) => List.generate(
        rowLenght,
        (j) => null,
      ),
    );

    gameOver = false;
    currentScore = 0;

    // form new piece
    formNewPiece();

    // start game
    startGame();
  }

  // check for a collision in a future position
  bool checkCollision(Direction direction) {
    // loop thorugh each position of the current piece to get the row and column value
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the row and column of the current position
      int row = currentPiece.position[i] ~/ rowLenght;
      int column = currentPiece.position[i] % rowLenght;

      // adjust the row and column based on the direction
      if (direction == Direction.down) {
        row += 1;
      } else if (direction == Direction.right) {
        column += 1;
      } else if (direction == Direction.left) {
        column -= 1;
      }

      // check if the piece is out of frame
      if (row >= columnLenght || column < 0 || column >= rowLenght) {
        return true;
      }

      // check if the adjusted position is already occupied by another piece
      if (row >= 0 && column >= 0 && gameBoard[row][column] != null) {
        return true;
      }
    }
    // if no collisions are detected then return false
    return false;
  }

  void checkLanding() {
    // if down direction is occupied
    if (checkCollision(Direction.down)) {
      // mark position as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = currentPiece.position[i] ~/ rowLenght;
        int column = currentPiece.position[i] % rowLenght;
        if (row >= 0 && column >= 0) {
          gameBoard[row][column] = currentPiece.type;
        }
      }

      // once landed create new piece
      formNewPiece();
    }
  }

  void formNewPiece() {
    // form a random object to generate random tetromino types
    Random random = Random();

    // random tetromino type
    Tetromino randomType =
        Tetromino.values[random.nextInt(Tetromino.values.length)];

    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  // move left
  void moveLeft() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move right
  void moveRight() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLines() {
    // check if the row is full
    for (var row = columnLenght - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (var column = 0; column < rowLenght; column++) {
        if (gameBoard[row][column] == null) {
          rowIsFull = false;
          break;
        }
      }

      // if the row is full clear the row and shift rows down
      if (rowIsFull) {
        for (var r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        //increase score
        increaseScore();
      }
    }
  }

  // increase score
  void increaseScore() {
    currentScore++;
  }

  // game over
  bool isGameOver() {
    // check if any column in the top row are filled
    for (var column = 0; column < rowLenght; column++) {
      if (gameBoard[0][column] != null) {
        return true;
      }
    }
    // if the top row is empty, the game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLenght * columnLenght,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLenght),
              itemBuilder: (context, index) {
                // get row and column of each index
                int row = index ~/ rowLenght;
                int column = index % rowLenght;

                // current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                  );
                }
                // landed pieces
                else if (gameBoard[row][column] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][column];
                  return Pixel(color: tetrominoColors[tetrominoType]);
                }

                // blank pixel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          // score
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Score: $currentScore",
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // game controls
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios),
                ),

                // rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: const Icon(Icons.rotate_right),
                ),

                // right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                resetGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
              ),
              child: const Text("Menu"),
            ),
          )
        ],
      ),
    );
  }
}
