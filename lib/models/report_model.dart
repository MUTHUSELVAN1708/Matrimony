import 'package:equatable/equatable.dart';

class ReportModel extends Equatable {
  final int? reportId;
  final List<String>? images;
  final String? name;
  final String? uniqueId;
  final int? age;
  final String? height;
  final String? education;
  final String? city;
  final String? state;
  final String? reportedAt;
  final String? reason;
  final int? userId;

  const ReportModel({
    this.reportId,
    this.images,
    this.name,
    this.uniqueId,
    this.age,
    this.height,
    this.education,
    this.city,
    this.state,
    this.reportedAt,
    this.reason,
    this.userId,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      reportId: json['reportId'] as int?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: json['name'] as String?,
      uniqueId: json['uniqueId'] as String?,
      age: json['age'] as int?,
      height: json['height'] as String?,
      education: json['education'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      reportedAt: json['reportedAt'] as String?,
      reason: json['reason'] as String?,
      userId: json['reportedUserId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'images': images,
      'name': name,
      'uniqueId': uniqueId,
      'age': age,
      'height': height,
      'education': education,
      'city': city,
      'state': state,
      'reportedAt': reportedAt,
      'reason': reason,
      'reportedUserId': userId
    };
  }

  @override
  List<Object?> get props => [
        reportId,
        images,
        name,
        uniqueId,
        age,
        height,
        education,
        city,
        state,
        reportedAt,
        reason,
        userId
      ];
}
