class UserModel {
  String fullname;
  String username;
  String email;
  String password;
  String dateOfBirth;
  String gender;
  String bio;
  String profilePhoto;

  UserModel({
    required this.fullname,
    required this.username,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.gender,
    required this.bio,
    required this.profilePhoto,
  });

  // Convert UserModel object to Firebase Map
  Map<String, dynamic> toFirebaseMap() {
    return {
      'fullname': fullname,
      'username': username,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'bio': bio,
      'profilePhoto': profilePhoto,
    };
  }

  // Convert Firebase Map to UserModel object
  static UserModel fromFirebaseMap(Map<String, dynamic> map) {
    return UserModel(
      fullname: map['fullname'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      gender: map['gender'] ?? '',
      bio: map['bio'] ?? '',
      profilePhoto: map['profilePhoto'] ?? '',
    );
  }
}
