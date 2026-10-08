import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.blue,
            padding: const EdgeInsets.only(
              bottom: 15,
              left: 20,
              right: 20,
            ),
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Notes App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Notes App',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Keep your ideas, lists, and reminders in one place',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF7F8C8D),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/notes');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Go to Notes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}