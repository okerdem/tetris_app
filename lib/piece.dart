import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/board.dart';
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
          -17,
          -16,
          -6,
          -5,
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
  int rotationState = 1;

  void rotatePiece() {
    // new position
    List<int> newPosition = [];

    // rotate the piece based on its type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            // assign new position
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 1:
            // assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 2:
            // assign new position
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght - 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 3:
            // assign new position
            newPosition = [
              position[1] - rowLenght + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
        break;

      case Tetromino.J:
        switch (rotationState) {
          case 0:
            // assign new position
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght - 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 1:
            // assign new position
            newPosition = [
              position[1] - rowLenght - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 2:
            // assign new position
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 3:
            // assign new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLenght + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
        break;

      case Tetromino.I:
        switch (rotationState) {
          case 0:
            // assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 1:
            // assign new position
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + 2 * rowLenght,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 2:
            // assign new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 3:
            // assign new position
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - 2 * rowLenght,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
        break;

      case Tetromino.O:
        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:
            // assign new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              position[1] + rowLenght,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 1:
            // assign new position
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 2:
            // assign new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              position[1] + rowLenght,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 3:
            // assign new position
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
        break;

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            // assign new position
            newPosition = [
              position[0] + rowLenght - 2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 1:
            // assign new position
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 2:
            // assign new position
            newPosition = [
              position[0] + rowLenght - 2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 3:
            // assign new position
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
        break;

      case Tetromino.T:
        switch (rotationState) {
          case 0:
            // assign new position
            newPosition = [
              position[2] - rowLenght,
              position[2],
              position[2] + 1,
              position[2] + rowLenght,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 1:
            // assign new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 2:
            // assign new position
            newPosition = [
              position[1] - rowLenght,
              position[1] - 1,
              position[1],
              position[1] + rowLenght,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;

          case 3:
            // assign new position
            newPosition = [
              position[2] - rowLenght,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            // check that new position is valid before assigning it
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
        break;
      default:
    }
  }

  // check if valid position
  bool positionIsValid(int position) {
    // get the row and column of position
    int row = position ~/ rowLenght;
    int column = position % rowLenght;

    // if the position is taken, return false
    if (row < 0 || column < 0 || gameBoard[row][column] != null) {
      return false;
    } else {
      return true;
    }
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (var position in piecePosition) {
      // return false if any position is already taken
      if (!positionIsValid(position)) {
        return false;
      }

      // get the column of position
      int column = position % rowLenght;

      // check if the first or last column is occupied
      if (column == 0) {
        firstColOccupied = true;
      }
      if (column == rowLenght - 1) {
        lastColOccupied = true;
      }
    }

    // if there is a piece in the first column and last column, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
