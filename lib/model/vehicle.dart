class Vehicle {
  String name;
  double price;

  Vehicle({
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
      };
}
