import 'package:equatable/equatable.dart';

class SentModel extends Equatable {
  final int? interestId;
  final List<String>? images;
  final String? name;
  final String? uniqueId;
  final int? age;
  final String? height;
  final String? education;
  final String? city;
  final String? state;
  final String? interestCreatedAt;
  final String? status;

  const SentModel(
      {this.interestId,
      this.images,
      this.name,
      this.uniqueId,
      this.age,
      this.height,
      this.education,
      this.city,
      this.state,
      this.interestCreatedAt,
      this.status});

  factory SentModel.fromJson(Map<String, dynamic> json, bool? isReceive) {
    return SentModel(
        interestId: json['interestId'] as int?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        name: json['name'] as String?,
        uniqueId: json['uniqueId'] as String?,
        age: json['age'] as int?,
        height: json['height'] as String?,
        education: json['education'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        interestCreatedAt: json['interestCreatedAt'] as String?,
        status: json['status'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      'interestId': interestId,
      'images': images,
      'name': name,
      'uniqueId': uniqueId,
      'age': age,
      'height': height,
      'education': education,
      'city': city,
      'state': state,
      'interestCreatedAt': interestCreatedAt,
      'status': status
    };
  }

  @override
  List<Object?> get props => [
        interestId,
        images,
        name,
        uniqueId,
        age,
        height,
        education,
        city,
        state,
        interestCreatedAt,
        status
      ];
}

class ReceiveModel extends Equatable {
  final int? interestId;
  final List<String>? images;
  final String? name;
  final String? uniqueId;
  final int? age;
  final String? height;
  final String? education;
  final String? city;
  final String? state;
  final String? interestCreatedAt;
  final String? status;

  const ReceiveModel(
      {this.interestId,
      this.images,
      this.name,
      this.uniqueId,
      this.age,
      this.height,
      this.education,
      this.city,
      this.state,
      this.interestCreatedAt,
      this.status});

  factory ReceiveModel.fromJson(Map<String, dynamic> json, bool? isReceive) {
    return ReceiveModel(
        interestId: json['interestId'] as int?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        name: json['name'] as String?,
        uniqueId: json['uniqueId'] as String?,
        age: json['age'] as int?,
        height: json['height'] as String?,
        education: json['education'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        interestCreatedAt: json['interestCreatedAt'] as String?,
        status: json['status'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      'interestId': interestId,
      'images': images,
      'name': name,
      'uniqueId': uniqueId,
      'age': age,
      'height': height,
      'education': education,
      'city': city,
      'state': state,
      'interestCreatedAt': interestCreatedAt,
      'status': status
    };
  }

  @override
  List<Object?> get props => [
        interestId,
        images,
        name,
        uniqueId,
        age,
        height,
        education,
        city,
        state,
        interestCreatedAt,
        status
      ];
}
