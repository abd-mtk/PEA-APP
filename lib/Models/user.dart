class User {
  String id;
  String name;
  String description;
  String phone;
  String email;
  String city;
  String profilePic;

  User({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.city,
    required this.phone,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'phone': phone,
      'email': email,
      'city': city,
      'profilePic': profilePic,
    };
  }
}
