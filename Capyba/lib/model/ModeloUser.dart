class ModeloUser {
  String? uid;
  String? email;
  String? name;
  String? lastName;

  ModeloUser({this.uid, this.email, this.name, this.lastName});

  factory ModeloUser.fromMap(map) {
    return ModeloUser(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      lastName: map['lastName'],
    );
  }

    Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'lastName': lastName,
    };
  }
}
