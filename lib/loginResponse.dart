// ignore_for_file: file_names

class LoginResponse {
  String accessToken;
  int userId;
  String username;

  LoginResponse({this.accessToken, this.userId, this.username});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userId = json['user_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['user_id'] = userId;
    data['username'] = username;
    return data;
  }
}
