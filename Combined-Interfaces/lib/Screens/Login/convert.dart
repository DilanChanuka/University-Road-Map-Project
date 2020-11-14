class UsersList {
  final List<User> users;

  UsersList({
    this.users,
  });

  factory UsersList.fromJson(List<dynamic> parsedJson) {

    List<User> users = new List<User>();
    users = parsedJson.map((i)=>User.fromJson(i)).toList();

    return new UsersList(
        users: users
    );
  }
}

class User{
  final String username;
  final String password;

  User({
    this.username,
    this.password
  }) ;

  factory User.fromJson(Map<String, dynamic> json){
    return new User(
      username: json['username'],
      password: json['password'],
    );
  }

}