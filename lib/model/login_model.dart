class LoginModel {
  bool status;
  String message;
  Data data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String token;
  Patient patient;

  Data({this.token, this.patient});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    return data;
  }
}

class Patient {
  int id;
  String name;
  String idNumber;
  String gender;
  String createdAt;
  String updatedAt;
  String type;

  Patient(
      {this.id,
        this.name,
        this.idNumber,
        this.gender,
        this.createdAt,
        this.updatedAt,
        this.type});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idNumber = json['id_number'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['id_number'] = this.idNumber;
    data['gender'] = this.gender;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    return data;
  }
}
