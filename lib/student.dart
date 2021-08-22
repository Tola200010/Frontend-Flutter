class Student {
  String address;
  String contact;
  String createAt;
  String dob;
  String email;
  String firstName;
  int id;
  String lastName;
  int userId;

  Student(
      {this.address,
      this.contact,
      this.createAt,
      this.dob,
      this.email,
      this.firstName,
      this.id,
      this.lastName,
        this.userId
      });

  Student.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    contact = json['contact'];
    createAt = json['create_at'];
    dob = json['dob'];
    email = json['email'];
    firstName = json['first_name'];
    id = json['id'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['create_at'] = this.createAt;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['last_name'] = this.lastName;
    data['user_id'] = userId;
    return data;
  }
}
