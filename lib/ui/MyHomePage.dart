import 'package:flutter/material.dart';
import 'package:image_viewer/model/Album.dart';
import 'package:image_viewer/repo/AppRepository.dart';
import 'package:image_viewer/ui/PhotosPage.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _repository = AppRepository();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: FutureBuilder<List<Album>>(
        future: _repository.getAlbums(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? AlbumsList(albums: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class AlbumsList extends StatelessWidget {
  final List<Album> albums;

  AlbumsList({Key key, this.albums}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: albums.length,
      padding: EdgeInsets.all(4.0),
      itemBuilder: (context, index) {
        return new InkWell(
            onTap: () {
              _moveNext(context, albums[index].id, albums[index].title);
            },
            child: GridTile(
              child: new Card(
                  color: Colors.blue.shade200,
                  child: new Center(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: new Text(
                          albums[index].title,
                          style: TextStyle(fontSize: 18),
                        )),
                  )),
            ));
      },
    );
  }

  _moveNext(context, albumId, title) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (_) => PhotosPage(
              title: title,
              albumId: albumId,
            )));
  }
}
