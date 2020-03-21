import 'package:flutter/material.dart';
import 'package:image_viewer/bloc/HomeBloc.dart';
import 'package:image_viewer/model/Photo.dart';
import 'package:image_viewer/ui/DisplayPhoto.dart';

class PhotosPage extends StatefulWidget {
  final albumId;
  final title;

  PhotosPage({this.title, this.albumId});

  @override
  State<StatefulWidget> createState() {
    return _PhotosPage(this.title, this.albumId);
  }
}

class _PhotosPage extends State<PhotosPage> {
  final albumId;
  final title;
  ScrollController _scrollController = new ScrollController();

  _PhotosPage(this.title, this.albumId);

  PhotosBloc _photosBloc;

  int _page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _photosBloc = PhotosBloc();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _photosBloc.getPhotos(albumId, ++_page);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _photosBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: _buildStream(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildStream() {
    _photosBloc.clearLocal();
    _photosBloc.getPhotos(albumId, _page);
    return StreamBuilder<List<Photo>>(
      stream: _photosBloc.photoList,
      builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const LinearProgressIndicator();
          default:
            if (snapshot.data == null || snapshot.data.isEmpty) {
              return Container();
            }
            return _itemList(snapshot.data);
        }
      },
    );
  }

  Widget _itemList(List<Photo> photos) {
    print("size: " +  photos.length.toString());
    return ListView.builder(
      itemCount: photos.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == photos.length) {
          isLoading = true;
          return _buildProgressIndicator();
        } else {
          isLoading = false;
          return rowWidget(photos[index]);
        }
      },
      controller: _scrollController,
    );
  }

  Widget rowWidget(Photo photo) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: InkWell(
            onTap: () => moveNext(photo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(photo.thumbnailUrl,
                      // width: 300,
                      height: 150,
                      fit: BoxFit.fill),
                ),
                ListTile(
                  title: Text( "Album Id: " + albumId.toString() + "   Photo Id: " + photo.id.toString()),
                  subtitle: Text(photo.title),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  moveNext(Photo photo) {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (_) => DisplayPhoto(photo: photo)));
  }
}
