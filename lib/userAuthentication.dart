// ignore_for_file: file_names

class UserAuthentication {
  String username;
  String password;

  UserAuthentication({this.username, this.password});

  UserAuthentication.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
