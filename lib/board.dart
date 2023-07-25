import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/piece.dart';
import 'package:flutter_tetris_app/pixel.dart';
import 'package:flutter_tetris_app/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
    columnLenght,
    (i) => List.generate(
          rowLenght,
          (j) => null,
        ));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

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
        // check landing
        checkLanding();

        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: rowLenght * columnLenght,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rowLenght),
        itemBuilder: (context, index) {
          if (currentPiece.position.contains(index)) {
            return Pixel(
              color: Colors.yellow,
              child: index.toString(),
            );
          } else {
            return Pixel(
              color: Colors.grey[900],
              child: index.toString(),
            );
          }
        },
      ),
    );
  }
}
