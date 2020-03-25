import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String username;
  final String token;
  final String fullName;
  final int phone;

  UserModel({this.id, this.username, this.token, this.fullName, this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'],
      token: json['token'],
      fullName: json['full_name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'username' : username,
    'token' : token,
    'full_name' : fullName,
    'phone' : phone,
  };

  @override
  // TODO: implement props
  List<Object> get props => [id, username, token, fullName, phone];
}
