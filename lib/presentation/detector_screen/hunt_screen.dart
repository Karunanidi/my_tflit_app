import 'package:flutter/material.dart';

class HuntScreen extends StatefulWidget {
  const HuntScreen({super.key});

  @override
  State<HuntScreen> createState() => _HuntScreenState();
}

class _HuntScreenState extends State<HuntScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top bar
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items left: 5',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '0/500',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),

              // Main content area
              const Column(
                children: [
                  Text(
                    'Next item to find:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 14.0),
                  Text(
                    'REMOTE',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              // Bottom buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Skip action
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: Colors.purple),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                    ),
                    child: const Text('Skip'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Take photo action
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Take photo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
