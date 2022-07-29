class Images {
  String id;
  String file;
  String type;
  String size;

  Images.fromJson(Map json)
      : id = json['id'],
        file = json['file'],
        type = json['type'],
        size = json['size'];

  Map toJson() {
    return {'id': id, 'file': file, 'type': type, 'size': size};
  }
}