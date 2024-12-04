import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  final int? id;
  final String? name;
  final int? age;
  final List<String>? images;
  final String? uniqueId;
  final String? occupation;
  final String? caste;
  final String? state;
  final String? city;

  const SearchModel(
      {this.id,
      this.name,
      this.age,
      this.images,
      this.uniqueId,
      this.occupation,
      this.caste,
      this.state,
      this.city});

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'age': age,
      'images': images,
      'uniqueId': uniqueId,
      'city': city,
      'state': state,
      'occupation': occupation,
      'caste': caste,
    };
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        id: json['userId'] as int?,
        name: json['name'] as String?,
        age: json['age'] as int?,
        images: (json['images'] as List<dynamic>?)
            ?.map((item) => item.toString())
            .toList(),
        occupation: json['occupation'] as String?,
        caste: json['caste'] as String?,
        state: json['state'] as String?,
        city: json['city'] as String?,
        uniqueId: json['uniqueId'] as String?);
  }

  @override
  List<Object?> get props =>
      [id, name, age, images, occupation, caste, state, city, uniqueId];
}
