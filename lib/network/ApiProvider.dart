import 'dart:convert';
import 'dart:core';
import 'package:image_viewer/model/Album.dart';
import 'package:image_viewer/model/Photo.dart';
import 'dart:async';
import 'package:http/http.dart' as http;



class ApiProvider {

  static final ApiProvider _singleton = ApiProvider._internal();
  factory ApiProvider() {
    return _singleton;
  }

  ApiProvider._internal();

  final _endpoint = "https://jsonplaceholder.typicode.com/";
  final _albums = "albums";
  final _photos = "photos";


  List<Photo> _parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  List<Album> _parseAlbum(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }

  Future<List<Photo>> fetchPhotos(albumId, page) async {
    var extra = "$albumId&_page=$page&_limit=10";
    final response = await http.get(_endpoint + _photos + "?albumId=" + extra);
    return _parsePhotos(response.body);
  }

  Future<List<Album>> fetchAlbum() async {
    final response = await http.get(_endpoint + _albums);
    return _parseAlbum(response.body);
  }
}
