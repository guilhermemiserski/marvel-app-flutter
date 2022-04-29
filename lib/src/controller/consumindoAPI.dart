import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/character.dart';
import 'package:http/http.dart' as http;

class ConsumindoAPI {
  static Future<List<Character>> getCharacters(String nomeHeroi) async {
    var ts = DateTime.now().toIso8601String();
    String apiPublic = '99b8305268f9960834d0b50745f17c53';
    String apiPrivate = 'ce428d2c87ade078c0ed7fad15c4dd51d31591f2';
    String interpolacao = '$ts$apiPrivate$apiPublic';
    var hash = md5.convert(utf8.encode(interpolacao)).toString();
    String url =
        'http://gateway.marvel.com/v1/public/characters?nameStartsWith=$nomeHeroi&ts=$ts&apikey=$apiPublic&hash=$hash';
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    var json = jsonDecode(response.body)['data']['results'];
    return json
        .map<Character>((personagem) => Character.fromJson(personagem))
        .toList();
  }
}
