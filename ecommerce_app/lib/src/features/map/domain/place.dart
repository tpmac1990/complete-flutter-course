/// * The product identifier is an important concept and can have its own type.
typedef PlaceID = String;

/// Class representing a product.
class Place {
  const Place({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.lat,
    required this.lng,
  });

  /// Unique place id
  final PlaceID id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final double lat;
  final double lng;

  @override
  String toString() {
    return 'Place(id: $id, imageUrl: $imageUrl, title: $title, description: $description, price: $price, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.id == id &&
        other.imageUrl == imageUrl &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.lat == lat &&
        other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        lat.hashCode ^
        lng.hashCode;
  }

  Place copyWith({
    PlaceID? id,
    String? imageUrl,
    String? title,
    String? description,
    double? price,
    double? lat,
    double? lng
  }) {
    return Place(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng
    );
  }
}
