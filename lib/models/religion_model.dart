class Religion {
  final int id;
  final String religion;

  Religion({
    required this.id,
    required this.religion,
  });

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      id: json['id'],
      religion: json['religion'],
    );
  }

  // Method to convert a Religion object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'religion': religion,
    };
  }
}

class Caste {
  final int id;
  final String castes;
  final int religionId;

  Caste({
    required this.id,
    required this.castes,
    required this.religionId,
  });

  // Factory constructor to create a Caste object from JSON
  factory Caste.fromJson(Map<String, dynamic> json) {
    return Caste(
      id: json['id'],
      castes: json['castes'],
      religionId: json['religionId'],
    );
  }

  // Method to convert a Caste object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'castes': castes,
      'religionId': religionId,
    };
  }
}

class SubCaste {
  final int id;
  final int casteId;
  final String subCaste;

  SubCaste({
    required this.id,
    required this.casteId,
    required this.subCaste,
  });

  // Factory constructor to create a SubCaste object from JSON
  factory SubCaste.fromJson(Map<String, dynamic> json) {
    return SubCaste(
      id: json['id'],
      casteId: json['casteId'],
      subCaste: json['subCaste'],
    );
  }

  // Method to convert a SubCaste object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'casteId': casteId,
      'subCaste': subCaste,
    };
  }
}
