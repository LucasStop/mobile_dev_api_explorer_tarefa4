import 'package:flutter/material.dart';
import 'dog_service.dart';

class DogGalleryScreen extends StatefulWidget {
  final Future<List<String>> Function() fetchImages;

  const DogGalleryScreen({super.key, this.fetchImages = fetchDogImages});

  @override
  State<DogGalleryScreen> createState() => _DogGalleryScreenState();
}

class _DogGalleryScreenState extends State<DogGalleryScreen> {
  late Future<List<String>> _futureImages;

  @override
  void initState() {
    super.initState();
    _futureImages = widget.fetchImages();
  }

  void _loadMore() {
    setState(() {
      _futureImages = widget.fetchImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galeria de Cães Aleatórios')),
      body: FutureBuilder<List<String>>(
        future: _futureImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Erro ao carregar: ${snapshot.error}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loadMore,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }
          final images = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadMore,
        tooltip: 'Carregar Mais',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
