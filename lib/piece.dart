import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/values.dart';

class Piece {
  // type of tetris piece
  Tetromino type;

  Piece({required this.type});

  // pieces are just a list of integers
  List<int> position = [];

  // color of the pieces
  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  // generate integers
  void initializePiece() {
    switch (type) {
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;

      case Tetromino.J:
        position = [
          -5,
          -6,
          -15,
          -25,
        ];
        break;

      case Tetromino.L:
        position = [
          -5,
          -6,
          -16,
          -26,
        ];
        break;

      case Tetromino.O:
        position = [
          -5,
          -6,
          -15,
          -16,
        ];
        break;

      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;

      case Tetromino.T:
        position = [
          -6,
          -16,
          -26,
          -15,
        ];
        break;

      case Tetromino.Z:
        position = [
          -6,
          -5,
          -16,
          -17,
        ];
        break;

      default:
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLenght;
        }
        break;

      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;

      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;

      default:
    }
  }

  // rotate piece
  int rotationState=1;
  
  void rotatePiece(){
    
  }
}
