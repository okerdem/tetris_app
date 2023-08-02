import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/board.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          children: [
            const Spacer(),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const GameBoard();
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    backgroundColor: Colors.orange[800],
                  ),
                  child: const Text(
                    "Play",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const GameBoard();
                      },
                    ),
                  );
                },
                color: Colors.grey,
                iconSize: 40,
                icon: Icon(Icons.light_mode_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}
