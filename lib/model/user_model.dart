class UserModel {
  late String name;
  late String email;
  late String image;
  late String uId;
  late String cover;
  late String phone;
  late String bio;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    required this.cover,
    required this.image,
    required this.uId,
  });

  UserModel.Info({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'cover': cover,
      'image': image,
      'bio': bio,
    };
  }
}
