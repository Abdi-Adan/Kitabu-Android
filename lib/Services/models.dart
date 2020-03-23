// import 'dart:convert';

class Creditor {
  int creditorId;
  int creditorPhoneNo;
  String creditorName;
  String date;

  Creditor(this.creditorId, this.creditorName, this.creditorPhoneNo, this.date);

  static final columns = [
    "creditorId",
    "creditorPhoneNo",
    "creditorName",
    "date"
  ];

  Map<String, dynamic> toMap() {
    Map map = {
      "creditorName": creditorName,
    };
    //
    if (creditorId < 8) {
      map["creditorId"] = creditorId;
    }
    if (creditorPhoneNo != null) {
      map["creditorPhoneNo"] = creditorPhoneNo;
    }
    return map;
  }

  Creditor.fromMap(Map<String, dynamic> map) {
    this.creditorId = map["creditorId"];
    this.creditorName = map["creditorName"];
    this.creditorPhoneNo = map["creditorPhoneNo"];
  }
}

// ////////////////////////////////////////////////////ItemDetails////////

class Items {
  int id;
  int userid;
  int priceq;
  int quantity;
  String itemname;
  Creditor creditor;

  Items(this.id, this.userid, this.priceq, this.itemname, this.quantity,
      this.creditor);

  static final columns = ["id", "userid", "priceq", "quantity", "itemname"];

  Map toMap() {
    Map map = {
      "itemname": itemname,
    };
    if (id != null) {
      map["id"] = id;
    }
    if (userid != null) {
      map["userid"] = userid;
    }
    if (priceq != null) {
      map["priceq"] = priceq;
    }
    if (quantity != null) {
      map["quantity"] = quantity;
    }
    return map;
  }

  Items.fromMap(Map map) {
    this.id = map["id"];
    this.itemname = map["itemname"];
    this.priceq = map["priceq"];
    this.quantity = map["quantity"];
    this.userid = map["userid"];
  }
}
