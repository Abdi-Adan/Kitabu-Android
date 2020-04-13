class Creditor {
  int id;
  String name; 
  int idnumber; 
  int phone;
  int owner;
  double debt; 

  Creditor(this.id, this.name, this.idnumber, this.phone, this.owner, this.debt);

  Creditor.fromJson(Map<String,dynamic> json)
    : id = json['id'],
    name = json['full_name'],
    idnumber = json['idnumber'],
    owner = json['owner'],
    phone = json['phone'],
    debt = json['debt'];
}