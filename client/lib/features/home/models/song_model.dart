import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class SongModel {
  final String id;
  final String song_name;
  final String artist;
  final String thumbnail_url;
  final String song_url;
  final String hexColor;
  SongModel({
    required this.id,
    required this.song_name,
    required this.artist,
    required this.thumbnail_url,
    required this.song_url,
    required this.hexColor,
  });

  SongModel copyWith({
    String? id,
    String? song_name,
    String? artist,
    String? thumbnail_url,
    String? song_url,
    String? hexColor,
  }) {
    return SongModel(
      id: id ?? this.id,
      song_name: song_name ?? this.song_name,
      artist: artist ?? this.artist,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_url: song_url ?? this.song_url,
      hexColor: hexColor ?? this.hexColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'song_name': song_name,
      'artist': artist,
      'thumbnail_url': thumbnail_url,
      'song_url': song_url,
      'hexColor': hexColor,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] ?? '',
      song_name: map['song_name'] ?? '',
      artist: map['artist'] ?? '',
      thumbnail_url: map['thumbnail_url'] ?? '',
      song_url: map['song_url'] ?? '',
      hexColor: map['hex_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(id: $id, song_name: $song_name, artist: $artist, thumbnail_url: $thumbnail_url, song_url: $song_url, hexColor: $hexColor)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.song_name == song_name &&
        other.artist == artist &&
        other.thumbnail_url == thumbnail_url &&
        other.song_url == song_url &&
        other.hexColor == hexColor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        song_name.hashCode ^
        artist.hashCode ^
        thumbnail_url.hashCode ^
        song_url.hashCode ^
        hexColor.hashCode;
  }
}
