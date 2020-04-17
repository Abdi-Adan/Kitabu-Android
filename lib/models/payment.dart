class Payment {
  
  int id; 
  int owner; 
  int creditorid;
  double amount;
  DateTime date; 

  Payment(this.id, this.owner, this.creditorid, this.amount, this.date);

  Payment.fromJson(Map<String,dynamic> json) 
    : id = json['id'],
      owner =  json['owner'], 
      creditorid = json['creditorid'],
      amount = json['amount'], 
      date = json['date'];
}