import 'package:equatable/equatable.dart';

class ShortlistModel extends Equatable {
  final int? id;
  final List<String>? images;
  final String? name;
  final String? uniqueId;
  final int? age;
  final String? height;
  final String? education;
  final String? city;
  final String? state;
  final String? addedAt;
  final int? userId;

  const ShortlistModel({
    this.id,
    this.images,
    this.name,
    this.uniqueId,
    this.age,
    this.height,
    this.education,
    this.city,
    this.state,
    this.addedAt,
    this.userId,
  });

  factory ShortlistModel.fromJson(Map<String, dynamic> json) {
    return ShortlistModel(
      id: json['id'] as int?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      uniqueId: json['uniqueId'] as String?,
      age: json['age'] as int?,
      height: json['height'] as String?,
      education: json['education'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      addedAt: json['addedAt'] as String?,
      userId: json['favoritedUserId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'images': images,
      'name': name,
      'uniqueId': uniqueId,
      'age': age,
      'height': height,
      'education': education,
      'city': city,
      'state': state,
      'addedAt': addedAt,
      'favoritedUserId': userId
    };
  }

  @override
  List<Object?> get props => [
        id,
        images,
        name,
        uniqueId,
        age,
        height,
        education,
        city,
        state,
        addedAt,
        userId
      ];
}
