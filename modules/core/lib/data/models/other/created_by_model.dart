import 'package:equatable/equatable.dart';

class CreatedByModel extends Equatable {
  CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  final int id;
  final String creditId;
  final String name;
  final int gender;
  final dynamic profilePath;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        gender,
        profilePath,
      ];
}
