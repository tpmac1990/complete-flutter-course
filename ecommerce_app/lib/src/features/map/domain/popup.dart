/// * The product identifier is an important concept and can have its own type.
typedef PlaceID = String;

/// Class representing a product.
class Popup {
  const Popup({
    required this.placeID,
  });

  /// Unique place id
  final PlaceID placeID;

  @override
  String toString() {
    return 'Popup(id: $placeID,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Popup &&
        other.placeID == placeID;
  }

  @override
  int get hashCode {
    return placeID.hashCode;
  }

  Popup copyWith({
    PlaceID? placeID
  }) {
    return Popup(
      placeID: placeID ?? this.placeID
    );
  }
}
