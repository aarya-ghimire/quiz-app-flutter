class GenderModel {
  final String? name;
  final String? gender;
  final double? probability;

  GenderModel({
    this.name,
    this.gender,
    this.probability,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
      name: json['name'],
      gender: json['gender'],
      probability: json['probability'],
    );
  }
}
