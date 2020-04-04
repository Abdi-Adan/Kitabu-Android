// import 'dart:convert';

class Debtor {
  int debtorId;
  int debtorPhoneNo;
  String debtorName;
  String date;

  Debtor(this.debtorId, this.debtorName, this.debtorPhoneNo, this.date);

  static final columns = [
    "debtorId",
    "debtorPhoneNo",
    "debtorName",
    "date"
  ];

  Map<String, dynamic> toMap() {
    Map map = {
      "debtorName": debtorName,
    };
    //
    if (debtorId < 8) {
      map["debtorId"] = debtorId;
    }
    if (debtorPhoneNo != null) {
      map["debtorPhoneNo"] = debtorPhoneNo;
    }
    return map;
  }

  Debtor.fromMap(Map<String, dynamic> map) {
    this.debtorId = map["debtorId"];
    this.debtorName = map["debtorName"];
    this.debtorPhoneNo = map["debtorPhoneNo"];
  }
}


