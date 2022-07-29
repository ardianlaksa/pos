import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpUploadService {

  Future<String> uploadPhotos(List<String> paths) async {
    Uri uri = Uri.parse('http://deenha.id/coba_flutter/insert.php');
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    for(String path in paths){
      request.files.add(await http.MultipartFile.fromPath('files[]', path));
    }

    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    print('\n\n');
    print('RESPONSE WITH HTTP');
    print(responseString);
    print('\n\n');
    return responseString;
  }

}