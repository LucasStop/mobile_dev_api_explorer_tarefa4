import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_dev_api_explorer_tarefa4/dog_gallery_screen.dart';

Future<List<String>> _neverResolves() => Completer<List<String>>().future;

Future<List<String>> _fakeImages() async => [
      'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
      'https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg',
    ];

void main() {
  testWidgets('DogGalleryScreen shows loading indicator initially', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DogGalleryScreen(fetchImages: _neverResolves)),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DogGalleryScreen shows grid after future resolves', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DogGalleryScreen(fetchImages: _fakeImages)),
    );
    await tester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
  });
}
