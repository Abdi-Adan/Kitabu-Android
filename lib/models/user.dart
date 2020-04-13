class User {
  
  final String name; 
  final String idnumber; 
  final String phone;
  final String password; 

  User({this.name, this.idnumber, this.phone, this.password});

  factory User.fromJson(Map<String,dynamic> json) {
    return User(
      name: json['name'], 
      idnumber: json['idnumber'],
      phone: json['phone'], 
      password: json['password'],
    );
  }
}