// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_places_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$placesRepositoryHash() => r'88790fff6074f5638b5c51e3b80afd165e899be1';

/// See also [placesRepository].
@ProviderFor(placesRepository)
final placesRepositoryProvider =
    AutoDisposeProvider<FakePlacesRepository>.internal(
  placesRepository,
  name: r'placesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$placesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlacesRepositoryRef = AutoDisposeProviderRef<FakePlacesRepository>;
String _$placesListStreamHash() => r'da34083b17493b9a7eb9836dc59b3e1e56d91250';

/// See also [placesListStream].
@ProviderFor(placesListStream)
final placesListStreamProvider =
    AutoDisposeStreamProvider<List<Place>>.internal(
  placesListStream,
  name: r'placesListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$placesListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlacesListStreamRef = AutoDisposeStreamProviderRef<List<Place>>;
String _$placesListFutureHash() => r'a36b054f91ac5d2639c3bfc70788bcc96f91d7df';

/// See also [placesListFuture].
@ProviderFor(placesListFuture)
final placesListFutureProvider =
    AutoDisposeFutureProvider<List<Place>>.internal(
  placesListFuture,
  name: r'placesListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$placesListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlacesListFutureRef = AutoDisposeFutureProviderRef<List<Place>>;
String _$placeHash() => r'8c640f66cabb79a59ad3d5362b716c527d901d5f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [place].
@ProviderFor(place)
const placeProvider = PlaceFamily();

/// See also [place].
class PlaceFamily extends Family<AsyncValue<Place?>> {
  /// See also [place].
  const PlaceFamily();

  /// See also [place].
  PlaceProvider call(
    String id,
  ) {
    return PlaceProvider(
      id,
    );
  }

  @override
  PlaceProvider getProviderOverride(
    covariant PlaceProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'placeProvider';
}

/// See also [place].
class PlaceProvider extends AutoDisposeStreamProvider<Place?> {
  /// See also [place].
  PlaceProvider(
    String id,
  ) : this._internal(
          (ref) => place(
            ref as PlaceRef,
            id,
          ),
          from: placeProvider,
          name: r'placeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$placeHash,
          dependencies: PlaceFamily._dependencies,
          allTransitiveDependencies: PlaceFamily._allTransitiveDependencies,
          id: id,
        );

  PlaceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Place?> Function(PlaceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlaceProvider._internal(
        (ref) => create(ref as PlaceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Place?> createElement() {
    return _PlaceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaceProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlaceRef on AutoDisposeStreamProviderRef<Place?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PlaceProviderElement extends AutoDisposeStreamProviderElement<Place?>
    with PlaceRef {
  _PlaceProviderElement(super.provider);

  @override
  String get id => (origin as PlaceProvider).id;
}

String _$placesListSearchHash() => r'a5c81e1f52d393669bce5900175fc62afcd5f7e5';

/// See also [placesListSearch].
@ProviderFor(placesListSearch)
const placesListSearchProvider = PlacesListSearchFamily();

/// See also [placesListSearch].
class PlacesListSearchFamily extends Family<AsyncValue<List<Place>>> {
  /// See also [placesListSearch].
  const PlacesListSearchFamily();

  /// See also [placesListSearch].
  PlacesListSearchProvider call(
    String query,
  ) {
    return PlacesListSearchProvider(
      query,
    );
  }

  @override
  PlacesListSearchProvider getProviderOverride(
    covariant PlacesListSearchProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'placesListSearchProvider';
}

/// See also [placesListSearch].
class PlacesListSearchProvider extends AutoDisposeFutureProvider<List<Place>> {
  /// See also [placesListSearch].
  PlacesListSearchProvider(
    String query,
  ) : this._internal(
          (ref) => placesListSearch(
            ref as PlacesListSearchRef,
            query,
          ),
          from: placesListSearchProvider,
          name: r'placesListSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$placesListSearchHash,
          dependencies: PlacesListSearchFamily._dependencies,
          allTransitiveDependencies:
              PlacesListSearchFamily._allTransitiveDependencies,
          query: query,
        );

  PlacesListSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Place>> Function(PlacesListSearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlacesListSearchProvider._internal(
        (ref) => create(ref as PlacesListSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Place>> createElement() {
    return _PlacesListSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlacesListSearchProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlacesListSearchRef on AutoDisposeFutureProviderRef<List<Place>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _PlacesListSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<Place>>
    with PlacesListSearchRef {
  _PlacesListSearchProviderElement(super.provider);

  @override
  String get query => (origin as PlacesListSearchProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
