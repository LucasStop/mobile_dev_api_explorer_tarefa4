import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

Future<Post> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
  throw Exception('Falha ao carregar o post (status ${response.statusCode})');
}
