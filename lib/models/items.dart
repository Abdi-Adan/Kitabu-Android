class Item {
  
  int id;
  String name; 
  int owner; 
  int borrower;
  double price;
  double quantity; 

  Item(this.id, this.name, this.owner, this.borrower, this.price, this.quantity);

  Item.fromJson(Map<String,dynamic> json) 
    : id = json['id'],
      name =  json['item_name'], 
      owner = json['owner'],
      borrower = json['borrower'], 
      price = json['price'],
      quantity = json['quantity'];
}