class User {
  String code;
  String createdAt;
  int id;
  bool status;
  String username;

  User.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    createdAt = json['createdAt'];
    id = json['id'];
    status = json['status'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['status'] = status;
    data['username'] = username;
    return data;
  }
}
