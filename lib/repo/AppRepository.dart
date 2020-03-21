import 'package:image_viewer/model/Album.dart';
import 'package:image_viewer/model/Photo.dart';
import 'package:image_viewer/network/ApiProvider.dart';

class AppRepository {


  static final AppRepository _singleton = AppRepository._internal();
  factory AppRepository() {
    return _singleton;
  }

  AppRepository._internal();

  ApiProvider _apiProvider = ApiProvider();

  Future<List<Album>> getAlbums() {
    return  _apiProvider.fetchAlbum();
  }

  Future<List<Photo>> getPhotos(albumId, page) {
    return _apiProvider.fetchPhotos(albumId, page);
  }
}
