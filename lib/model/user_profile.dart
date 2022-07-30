import '../globals.dart';
class User_Profile {
  final String firstName;
  final String lastName;
  final String cellPhone;
  final DateTime birthDate;
  final bool sendTextReminders;
  final bool sendEmailReminders;
  final bool cellphonevalidated;

  User_Profile({
    required this.firstName,
    required this.lastName,
    required this.cellPhone,
    required this.birthDate,
    required this.sendTextReminders,
    required this.sendEmailReminders,
    required this.cellphonevalidated,
});
  Map<String, dynamic> toJson() => {
    gFirstName: firstName,
    gLastName: lastName,
    gCellPhone: cellPhone,
    gBirthDate: birthDate,
    gSendTextReminders: sendTextReminders,
    gSendEmailReminders: sendEmailReminders,
    gCellPhoneValidated: cellphonevalidated,
  };

  static User_Profile fromJson(Map<String, dynamic> json) => User_Profile(
      firstName: json[gFirstName],
      lastName: json[gLastName],
      cellPhone: json[gCellPhone],
      birthDate: json[gBirthDate],
      sendTextReminders: json[gSendTextReminders],
      sendEmailReminders: json[gSendEmailReminders],
      cellphonevalidated: json[gCellPhoneValidated],
  );
}