import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/pixel.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // grid dimensions
  int rowLenght = 10;
  int columnLenght = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: rowLenght * columnLenght,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rowLenght),
        itemBuilder: (context, index) => Pixel(
          color: Colors.grey[900],
          child: index.toString(),
        ),
      ),
    );
  }
}
