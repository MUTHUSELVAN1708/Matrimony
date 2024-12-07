import 'package:equatable/equatable.dart';

class SuccessStory extends Equatable {
  final int? id;
  final String? weddingDate;
  final String? image;

  const SuccessStory({
    this.id,
    this.weddingDate,
    this.image,
  });

  factory SuccessStory.fromJson(Map<String, dynamic> json) {
    return SuccessStory(
      id: json['id'] as int?,
      weddingDate: json['weddingDate'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingDate': weddingDate,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, weddingDate, image];
}
