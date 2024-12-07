class Plan {
  final int planId;
  final String duration;
  final String packageName;
  final int totalProfiles;
  final String serviceName;
  final double priceInr;
  final List<PlanDetail> planDetails;

  Plan({
    required this.planId,
    required this.duration,
    required this.packageName,
    required this.totalProfiles,
    required this.serviceName,
    required this.priceInr,
    required this.planDetails,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planId: json['planId'],
      duration: json['Duration'],
      packageName: json['packageName'],
      totalProfiles: json['TotalProfiles'],
      serviceName: json['serviceName'],
      priceInr: json['priceInr'],
      planDetails: (json['planDetails'] as List)
          .map((detail) => PlanDetail.fromJson(detail))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'Duration': duration,
      'packageName': packageName,
      'TotalProfiles': totalProfiles,
      'serviceName': serviceName,
      'priceInr': priceInr,
      'planDetails': planDetails.map((detail) => detail.toJson()).toList(),
    };
  }
}

class PlanDetail {
  final bool isAvailableFor6Months;
  final String featureName;
  final String? featureDescription;
  final bool isAvailableFor3Months;

  PlanDetail({
    required this.isAvailableFor6Months,
    required this.featureName,
    this.featureDescription,
    required this.isAvailableFor3Months,
  });

  factory PlanDetail.fromJson(Map<String, dynamic> json) {
    return PlanDetail(
      isAvailableFor6Months: json['isAvailableFor6Months'],
      featureName: json['featureName'],
      featureDescription: json['featureDescription'],
      isAvailableFor3Months: json['isAvailableFor3Months'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAvailableFor6Months': isAvailableFor6Months,
      'featureName': featureName,
      'featureDescription': featureDescription,
      'isAvailableFor3Months': isAvailableFor3Months,
    };
  }
}
