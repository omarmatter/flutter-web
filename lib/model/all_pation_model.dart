class AllPationtModel {
  bool status;
  String message;
  Data data;

  AllPationtModel({this.status, this.message, this.data});

  AllPationtModel.fromJson(Map<String, dynamic> json) {
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
  List<Patients> patients;
  Pagination pagination;

  Data({this.patients, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['patients'] != null) {
      patients = new List<Patients>();
      json['patients'].forEach((v) {
        patients.add(new Patients.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patients != null) {
      data['patients'] = this.patients.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Patients {
  int id;
  String name;
  String idNumber;
  String gender;

  Patients({this.id, this.name, this.idNumber, this.gender});

  Patients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idNumber = json['id_number'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['id_number'] = this.idNumber;
    data['gender'] = this.gender;
    return data;
  }
}

class Pagination {
  int total;
  int count;
  int perPage;
  int currentPage;
  int lastPage;
  int from;
  int to;

  Pagination(
      {this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.lastPage,
        this.from,
        this.to});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
