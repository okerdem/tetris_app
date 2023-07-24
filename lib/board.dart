import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/piece.dart';
import 'package:flutter_tetris_app/pixel.dart';
import 'package:flutter_tetris_app/values.dart';

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

  void gameLoop(Duration frameRate){
    Timer.periodic(frameRate, (timer) { 
      setState(() {
        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
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
