class LoginResponse {
  final int? status;
  final String? message;
  final Data? data;

  LoginResponse({this.status, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final User? user;
  final String? token;

  Data({this.user, this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}

class User {
  final String? usrname;
  final String? usrEmail;
  final String? usrName;
  final String? role;
  final int? id;
  final String? delYn;
  final String? usrId;
  final String? personalProfile;

  User({
    this.usrname,
    this.usrEmail,
    this.usrName,
    this.role,
    this.id,
    this.delYn,
    this.usrId,
    this.personalProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      usrname: json['usrname'],
      usrEmail: json['usr_email'],
      usrName: json['usr_name'],
      role: json['role'],
      id: json['id'],
      delYn: json['del_yn'],
      usrId: json['usr_id'],
      personalProfile: json['personalProfile'],
    );
  }
}
