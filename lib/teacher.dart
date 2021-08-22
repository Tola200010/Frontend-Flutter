class Teacher {
  String address;
  String contact;
  String createdAt;
  String email;
  String firstName;
  int id;
  String lastName;
  int userId;

  Teacher(
      {this.address,
      this.contact,
      this.createdAt,
      this.email,
      this.firstName,
      this.id,
      this.lastName,
      this.userId});

  Teacher.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    contact = json['contact'];
    createdAt = json['createdAt'];
    email = json['email'];
    firstName = json['first_name'];
    id = json['id'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['contact'] = contact;
    data['createdAt'] = createdAt;
    data['email'] = email;
    data['first_name'] = firstName;
    data['id'] = id;
    data['last_name'] = lastName;
    data['user_id'] = userId;
    return data;
  }
}
