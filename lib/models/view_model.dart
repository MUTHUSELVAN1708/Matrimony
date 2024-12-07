import 'package:equatable/equatable.dart';

class ViewModel extends Equatable {
  final int? viewId;
  final List<String>? images;
  final String? name;
  final String? uniqueId;
  final int? age;
  final String? height;
  final String? education;
  final String? city;
  final String? state;
  final String? viewedAt;
  final int? userId;

  const ViewModel({
    this.viewId,
    this.images,
    this.name,
    this.uniqueId,
    this.age,
    this.height,
    this.education,
    this.city,
    this.state,
    this.viewedAt,
    this.userId,
  });

  factory ViewModel.fromJson(Map<String, dynamic> json) {
    return ViewModel(
      viewId: json['id'] as int?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      uniqueId: json['uniqueId'] as String?,
      age: json['age'] as int?,
      height: json['height'] as String?,
      education: json['education'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      viewedAt: json['viewedAt'] as String?,
      userId: json['vieweId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': viewId,
      'images': images,
      'name': name,
      'uniqueId': uniqueId,
      'age': age,
      'height': height,
      'education': education,
      'city': city,
      'state': state,
      'viewedAt': viewedAt,
      'vieweId': userId
    };
  }

  @override
  List<Object?> get props => [
        viewId,
        images,
        name,
        uniqueId,
        age,
        height,
        education,
        city,
        state,
        viewedAt,
        userId
      ];
}
