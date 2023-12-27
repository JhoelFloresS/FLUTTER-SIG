import "dart:convert";

import "package:http/http.dart" as http;

class MercadoService {
  final String _baseUrl = "laravel-production-54e9.up.railway.app";
  final List tiendas = [];

  Future<List> searchStore(String text) async {
    final url = Uri.https(_baseUrl, "api/productos/buscador");

    final resp = await http.post(url, body: {
      "buscar_texto": text
    });
    final decodeData = jsonDecode(resp.body);
    return decodeData;
  }
}