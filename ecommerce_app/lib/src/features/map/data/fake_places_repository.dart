import 'dart:async';

import 'package:ecommerce_app/src/constants/test_places.dart';
import 'package:ecommerce_app/src/features/map/domain/place.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_places_repository.g.dart';

class FakePlacesRepository {
  FakePlacesRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload with the default list of places when the app starts
  final _places = InMemoryStore<List<Place>>(List.from(kTestPlaces));

  List<Place> getPlacesList() {
    return _places.value;
  }

  Place? getPlace(String id) {
    return _getPlace(_places.value, id);
  }

  Future<List<Place>> fetchPlacesList() async {
    return Future.value(_places.value);
  }

  Stream<List<Place>> watchPlacesList() {
    return _places.stream;
  }

  Stream<Place?> watchPlace(String id) {
    return watchPlacesList().map((places) => _getPlace(places, id));
  }

  /// Update place or add a new one
  Future<void> setPlace(Place place) async {
    await delay(addDelay);
    final places = _places.value;
    final index = places.indexWhere((p) => p.id == place.id);
    if (index == -1) {
      // if not found, add as a new place
      places.add(place);
    } else {
      // else, overwrite previous place
      places[index] = place;
    }
    _places.value = places;
  }

  /// Search for places where the title contains the search query
  Future<List<Place>> searchPlaces(String query) async {
    assert(
      _places.value.length <= 100,
      'Client-side search should only be performed if the number of places is small. '
      'Consider doing server-side search for larger datasets.',
    );
    // Get all places
    final placesList = await fetchPlacesList();
    // Match all places where the title contains the query
    return placesList
        .where((place) =>
            place.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Place? _getPlace(List<Place> places, String id) {
    try {
      return places.firstWhere((place) => place.id == id);
    } catch (e) {
      return null;
    }
  }
}

@riverpod
FakePlacesRepository placesRepository(PlacesRepositoryRef ref) {
  // * Set addDelay to false for faster loading
  return FakePlacesRepository(addDelay: false);
}

@riverpod
Stream<List<Place>> placesListStream(PlacesListStreamRef ref) {
  final placesRepository = ref.watch(placesRepositoryProvider);
  return placesRepository.watchPlacesList();
}

@riverpod
Future<List<Place>> placesListFuture(PlacesListFutureRef ref) {
  final placesRepository = ref.watch(placesRepositoryProvider);
  return placesRepository.fetchPlacesList();
}

@riverpod
Stream<Place?> place(PlaceRef ref, PlaceID id) {
  final placesRepository = ref.watch(placesRepositoryProvider);
  return placesRepository.watchPlace(id);
}

@riverpod
Future<List<Place>> placesListSearch(
    PlacesListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  // * keep previous search results in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  final placesRepository = ref.watch(placesRepositoryProvider);
  return placesRepository.searchPlaces(query);
}
