import 'package:equatable/equatable.dart';

class BlockModel extends Equatable {
  final int? blockId;
  final List<String>? images;
  final String? name;
  final String? uniqueId;
  final int? age;
  final String? height;
  final String? education;
  final String? city;
  final String? state;
  final String? blockedAt;
  final int? userId;

  const BlockModel({
    this.blockId,
    this.images,
    this.name,
    this.uniqueId,
    this.age,
    this.height,
    this.education,
    this.city,
    this.state,
    this.blockedAt,
    this.userId,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    return BlockModel(
      blockId: json['blockId'] as int?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      uniqueId: json['uniqueId'] as String?,
      age: json['age'] as int?,
      height: json['height'] as String?,
      education: json['education'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      blockedAt: json['blockedAt'] as String?,
      userId: json['blockedUserId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockId': blockId,
      'images': images,
      'name': name,
      'uniqueId': uniqueId,
      'age': age,
      'height': height,
      'education': education,
      'city': city,
      'state': state,
      'blockedAt': blockedAt,
      'blockedUserId': userId
    };
  }

  @override
  List<Object?> get props => [
        blockId,
        images,
        name,
        uniqueId,
        age,
        height,
        education,
        city,
        state,
        blockedAt,
        userId
      ];
}

class DoNotShowModel extends Equatable {
  final int? id;
  final List<String>? images;
  final String? name;
  final String? uniqueId;
  final int? age;
  final String? height;
  final String? education;
  final String? city;
  final String? state;
  final String? createdAt;
  final String? status;
  final int? userId;

  const DoNotShowModel({
    this.id,
    this.images,
    this.name,
    this.uniqueId,
    this.age,
    this.height,
    this.education,
    this.city,
    this.state,
    this.createdAt,
    this.status,
    this.userId,
  });

  factory DoNotShowModel.fromJson(Map<String, dynamic> json) {
    return DoNotShowModel(
        id: json['id'] as int?,
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
        createdAt: json['createdAt'] as String?,
        status: json['status'] as String?,
        userId: json['hiddenId'] as int?);
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
      'createdAt': createdAt,
      'status': status,
      'hiddenId': userId
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
        createdAt,
        status,
        userId
      ];
}
