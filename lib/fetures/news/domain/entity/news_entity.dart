import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String? newsId;
  final String title;
  final String location;
  final String description;

  final String? image;
  final String user;

  const NewsEntity({
    this.newsId,
    required this.title,
    required this.location,
    required this.description,
    this.image,
    required this.user,
  });

  static String postId = '';

  factory NewsEntity.fromJson(Map<String, dynamic> json) => NewsEntity(
        newsId: json['newsId'],
        title: json['title'],
        location: json['location'],
        description: json['description'],
        image: json['image'],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "newsId": newsId,
        "title": title,
        "location": location,
        "description": description,
        'image': image,
        "user": user,
      };

  @override
  List<Object?> get props => [
        newsId,
        title,
        location,
        description,
        image,
        user,
      ];
}
