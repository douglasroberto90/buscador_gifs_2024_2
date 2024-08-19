import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Repositorio {

  late String apiKey;
  
  Future<void> inicializarDotEnv() async {
    await dotenv.load(fileName: "keys.env");
    apiKey = dotenv.get("API_KEY");
  }
  
  Future<Map<String, dynamic>> buscarTrending() async {
    inicializarDotEnv();
    final response = await http.get(Uri.parse(
        "https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=20&offset=0&rating=g&bundle=messaging_non_clips"));
    return jsonDecode(response.body);
  }
  
  Future<Map<String, dynamic>> buscarGifs(String termoBusca) async {
    inicializarDotEnv();
    Uri url = Uri.https("api.giphy.com","/v1/gifs/search",{
      "api_key":apiKey,
      "q": termoBusca,
      "rating":"g",
      "lang":"pt",
      "bundle":"messaging_non_clips"
    });
    final response = await http.get(url);
    return jsonDecode(response.body);
  }
}