import 'package:flutter/material.dart';
import 'package:flutter_tetris_app/board.dart';
import 'package:flutter_tetris_app/main.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool _darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                  setState(() {
                    _darkTheme
                        ? MyApp.of(context).changeTheme(ThemeMode.dark)
                        : MyApp.of(context).changeTheme(ThemeMode.light);
                    _darkTheme = !_darkTheme;
                  });
                },
                color: _darkTheme ? Colors.grey[400] : Colors.yellow,
                iconSize: 40,
                icon: _darkTheme
                    ? const Icon(Icons.light_mode_outlined)
                    : const Icon(Icons.light_mode),
              ),
            )
          ],
        ),
      ),
    );
  }
}
