import 'dart:core';

import 'package:image_viewer/model/Album.dart';
import 'package:image_viewer/model/Photo.dart';
import 'package:image_viewer/repo/AppRepository.dart';
import 'package:rxdart/rxdart.dart';

class PhotosBloc extends Object {

  final AppRepository _repository = AppRepository();

  final BehaviorSubject<List<Photo>> _photoList = new BehaviorSubject<List<Photo>>.seeded(List<Photo>());

  BehaviorSubject<List<Photo>> get photoList => _photoList;

  clearLocal() {
    _photoList.value.clear();
  }
  getPhotos(albumId, page) async {
   var list = await _repository.getPhotos(albumId, page);
   _photoList.value.addAll(list);
   _photoList.sink.add(_photoList.value);
  }

  dispose() {
    _photoList.close();
  }
}
