class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String profileImageURL; // New field for profile image
  final String password; // New field for password
  String imageid;
  String address;

  UserModel({
    required this.address,
    required this.imageid,
    required this.uid,
    required this.email,
    required this.displayName,
    this.profileImageURL =
        'https://example.com/profile.jpg', // Default profile image URL
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      "imageid": imageid,
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'profileImageURL': profileImageURL,
      'password': password,
      // Add more fields as needed
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      address: map["address"],
      imageid: map["imageid"],
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      profileImageURL: map['profileImageURL'],
      password: map['password'],
    );
  }
}

UserModel? globaluserdata;
