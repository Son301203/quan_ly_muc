class Item {
  String name;
  String value;
  bool isMonitoring;
  double price;  // Thêm thuộc tính price để lưu giá của mục
  bool isInCart;  // Thêm thuộc tính kiểm tra mục có trong giỏ hàng

  Item({
    required this.name,
    required this.value,
    this.isMonitoring = false,
    required this.price,
    this.isInCart = false,
  });

  // Phương thức copyWith cho phép tạo ra một bản sao mới với một số thay đổi
  Item copyWith({
    String? name,
    String? value,
    bool? isMonitoring,
    double? price,
    bool? isInCart,
  }) {
    return Item(
      name: name ?? this.name,
      value: value ?? this.value,
      isMonitoring: isMonitoring ?? this.isMonitoring,
      price: price ?? this.price,
      isInCart: isInCart ?? this.isInCart,
    );
  }

  // Chuyển Item thành Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'isMonitoring': isMonitoring,
      'price': price,
      'isInCart': isInCart,
    };
  }

  // Chuyển Map (JSON) thành Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      value: json['value'],
      isMonitoring: json['isMonitoring'] ?? false,
      price: json['price'],
      isInCart: json['isInCart'] ?? false,
    );
  }
}
