class User_Profile {
  final String firstName;
  final String lastName;
  final String cellPhone;
  final DateTime birthDate;
  final bool sendTextReminders;
  final bool sendEmailReminders;

  User_Profile({
    required this.firstName,
    required this.lastName,
    required this.cellPhone,
    required this.birthDate,
    required this.sendTextReminders,
    required this.sendEmailReminders,
});
  Map<String, dynamic> toJson() => {
    'firstname': firstName,
    'lastname': lastName,
    'cellphone': cellPhone,
    'birthdate': birthDate,
    'sendtextreminders': sendTextReminders,
    'sendemailreminders': sendEmailReminders,
  };

  static User_Profile fromJson(Map<String, dynamic> json) => User_Profile(
      firstName: json['firstname'],
      lastName: json['lastname'],
      cellPhone: json['cellphone'],
      birthDate: json['birthdate'],
      sendTextReminders: json['sendtextreminders'],
      sendEmailReminders: json['sendEmailReminders']);
}