class CartItem {
  String id;
  String productName;
  String shopId;
  String description1;
  String description2;
  String image;
  int costPrice;
  int sellingPrice;
  int quantityAvailable;
  String addedOn;
  int numberOfItems;
  String shopNumber;

  CartItem({
    required this.id,
    required this.productName,
    required this.shopId,
    required this.description1,
    required this.description2,
    required this.image,
    required this.costPrice,
    required this.sellingPrice,
    required this.quantityAvailable,
    required this.addedOn,
    required this.numberOfItems,
    required this.shopNumber,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        id: json['id'],
        productName: json['productName'],
        shopId: json['shopId'],
        description1: json['description1'],
        description2: json['description2'],
        image: json['image'],
        costPrice: json['costPrice'],
        sellingPrice: json['sellingPrice'],
        quantityAvailable: json['quantityAvailable'],
        addedOn: json['addedOn'],
        numberOfItems: json['numberOfItems'],
        shopNumber: json['shopNumber'],);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['shopId'] = this.shopId;
    data['description1'] = this.description1;
    data['description2'] = this.description2;
    data['image'] = this.image;
    data['costPrice'] = this.costPrice;
    data['sellingPrice'] = this.sellingPrice;
    data['quantityAvailable'] = this.quantityAvailable;
    data['addedOn'] = this.addedOn;
    data['numberOfItems'] = this.numberOfItems;
    data['shopNumber'] = this.shopNumber;
    return data;
  }
}
