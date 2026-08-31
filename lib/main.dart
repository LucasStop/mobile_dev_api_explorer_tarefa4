import 'package:flutter/material.dart';
import 'post_screen.dart';
import 'dog_gallery_screen.dart';

void main() {
  runApp(const ApiExplorerApp());
}

class ApiExplorerApp extends StatelessWidget {
  const ApiExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Explorer — Tarefa 4',
      theme: ThemeData(colorSchemeSeed: Colors.blueGrey, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Explorer — Tarefa 4')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostScreen()),
              ),
              child: const Text('Tutorial: Future + http'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DogGalleryScreen()),
              ),
              child: const Text('Galeria de Cães Aleatórios'),
            ),
          ],
        ),
      ),
    );
  }
}
