
class Photo {

  final int id;
  final String title;
  final String thumbnailUrl;
  final String url;

  Photo({this.id, this.title, this.thumbnailUrl, this.url});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}