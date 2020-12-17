class Tag {
  String username;
  String email;
  String password;

  Tag(this.username, this.email,this.password);

  Map toJson() => {
    'username': username,
    'email': email,
    'password':password
  };
}

class Newsign {
  final String username;
  final String email;
  final String password;

  Newsign({this.username, this.email,this.password});

  factory Newsign.fromJson(Map<String, dynamic> json) {
    return Newsign(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}