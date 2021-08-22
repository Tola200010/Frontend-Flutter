class Course {
  String createdAt;
  String endDate;
  int id;
  String name;
  double price;
  String startDate;
  int teacherId;
  int limitStudent;
  int userId;

  Course(
      {this.createdAt,
      this.endDate,
      this.id,
      this.name,
      this.price,
      this.startDate,
      this.teacherId,
      this.limitStudent,
      this.userId});

  Course.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    endDate = json['end_date'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    startDate = json['start_date'];
    teacherId = json['teacher_id'];
    limitStudent = json['limit_student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['end_date'] = this.endDate;
    data['id'] = id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['start_date'] = this.startDate;
    data['teacher_id'] = this.teacherId;
    data['limit_student'] = this.limitStudent;
    data['user_id'] = userId;
    return data;
  }
}
