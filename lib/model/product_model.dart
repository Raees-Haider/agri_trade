class Product {
  final String name;
  final double price;
  final String image;
  final int quantity;
  final String farmerID;
  String? productID; // Nullable productID
  final String description;

  // Bid-related fields
  double highestBid;
  String? highestBidderID;
  String? highestBidderEmail;
  String? highestBidderName;

  // New field to track if the bid is accepted
  bool accepted;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.farmerID,
    required this.description,
    this.productID,
    this.highestBid = 0.0,
    this.highestBidderID,
    this.highestBidderEmail,
    this.highestBidderName,
    this.accepted = false, // Default to false
  });

  // Method to convert Product object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
      'farmerID': farmerID,
      'productID': productID,
      'description': description,
      'highestBid': highestBid,
      'highestBidderID': highestBidderID,
      'highestBidderEmail': highestBidderEmail,
      'highestBidderName': highestBidderName,
      'accepted': accepted, // Add accepted field to the map
    };
  }

  // Factory method to create a Product object from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      farmerID: map['farmerID'] ?? '',
      description: map['description'] ?? '',
      productID: map['productID'], // Keep it nullable
      highestBid: map['highestBid']?.toDouble() ?? 0.0, // Handle possible null
      highestBidderID: map['highestBidderID'],
      highestBidderEmail: map['highestBidderEmail'],
      highestBidderName: map['highestBidderName'],
      accepted: map['accepted'] ?? false, // Handle possible null
    );
  }
}
