class AppUser {
  final String name;
  final String email;
  final String mobile;
  final String image;
  final String uid;
  final String pwd;
  const AppUser({
    required this.name,
    required this.email,
    required this.mobile,
    required this.image,
    required this.uid,
    required this.pwd,
  });

  AppUser copy({
    String? name,
    String? email,
    String? mobile,
    String? image,
    String? uid,
    String? pwd,
  }) =>
      AppUser(
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        image: image ?? this.image,
        uid: uid ?? this.uid,
        pwd: pwd ?? this.pwd,
      );

  static AppUser fromJson(Map<String, dynamic> json) => AppUser(
    name: json['name'],
    email: json['email'],
    mobile: json['mobile'],
    image: json['image'],
    uid: json['uid'] ?? '',
    pwd: json['pwd'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'mobile': mobile,
    'image': image,
    'uid': uid,
    'pwd': pwd,
  };
}