import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchDogImages() async {
  final response = await http
      .get(Uri.parse('https://dog.ceo/api/breeds/image/random/10'));

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return List<String>.from(decoded['message'] as List);
  }
  throw Exception('Falha ao carregar as imagens (status ${response.statusCode})');
}
