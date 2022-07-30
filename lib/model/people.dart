import '../globals.dart';
class Person {
  final String firstName;
  final String lastName;
  final DateTime anniversary;
  final String anniversaryType;
  final DateTime birthDate;
  final int randomReminders;
  final String relationshipType;
  final String userId;

  Person({
    required this.firstName,
    required this.lastName,
    required this.anniversary,
    required this.anniversaryType,
    required this.birthDate,
    required this.randomReminders,
    required this.relationshipType,
    required this.userId,
  });
  Map<String, dynamic> toJson() => {
    gFirstName: firstName,
    gLastName: lastName,
    gAnniversary: anniversary,
    gAnniversaryType: anniversaryType,
    gBirthDate: birthDate,
    gRandomReminders: randomReminders,
    gRelationshipType: relationshipType,
    gUserId: userId,
  };

  static Person fromJson(Map<String, dynamic> json) => Person(
    firstName: json[gFirstName],
    lastName: json[gLastName],
    anniversary: json[gAnniversary],
    anniversaryType: json[gAnniversaryType],
    birthDate: json[gBirthDate],
    randomReminders: json[gRandomReminders],
    relationshipType: json[gRelationshipType],
    userId: json[gUserId],
  );
}