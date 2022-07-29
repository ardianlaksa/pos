import 'dart:async';
import 'package:http/http.dart' as http;

class ImagesApi {
  static Future getImages() {
    Uri uri = Uri.parse('http://deenha.id/coba_flutter/select.php');
    return http.get(uri);
  }
}