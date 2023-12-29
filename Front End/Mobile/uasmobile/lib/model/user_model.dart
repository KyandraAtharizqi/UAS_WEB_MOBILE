class User {
  final int id;
  String usr;
  String pwd;
  final String level;
  final int isActive;
  String favmovie;
  String userdetail;

  User({
    required this.id,
    required this.usr,
    required this.pwd,
    required this.level,
    required this.isActive,
    required this.favmovie,
    required this.userdetail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      usr: json['usr'],
      pwd: json['pwd'],
      level: json['level'],
      isActive: json['isActive'],
      favmovie: json['favmovie'],
      userdetail: json['userdetail'],

    );
  }
}