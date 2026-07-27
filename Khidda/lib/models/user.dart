class UserProfile {
  final String uid;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? address;

  UserProfile({
    required this.uid,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.address,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
