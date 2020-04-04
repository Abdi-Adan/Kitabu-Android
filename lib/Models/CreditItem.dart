import 'package:kitabu_android/Models/debtor.dart';

class Items {
  int id;
  int userid;
  int priceq;
  int quantity;
  String itemname;
  Debtor debtor;

  Items(this.id, this.userid, this.priceq, this.itemname, this.quantity,
      this.debtor);

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
