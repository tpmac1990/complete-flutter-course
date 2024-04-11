import 'dart:async';
// import 'dart:typed_data';
import 'package:ecommerce_app/src/features/map/data/fake_place_popup_repository.dart';
import 'package:ecommerce_app/src/features/map/data/fake_places_repository.dart';
import 'package:ecommerce_app/src/features/map/domain/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'dart:ui' as ui;

// checkout ecommerce_app/lib/src/features/checkout/presentation/checkout_screen/checkout_screen.dart
//  for ConsumerStatefulWidget

part 'map_view.g.dart';

@riverpod
class MapCompleter extends _$MapCompleter {
  @override
  Completer<GoogleMapController> build() {
    return Completer();
  }

  void addController(controller) {
    state.complete(controller);
  }
}

// const MapViewScreen({super.key});
  // final Completer<GoogleMapController> _controller = Completer();

class MapViewScreen extends ConsumerWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10.0,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 14.0,
  );

  // final String svgString = '''
  //   <svg version="1.1" viewBox="0 0 70 70" xmlns="http://www.w3.org/2000/svg">
  //     <g transform="translate(-35 -35)">
  //       <circle cx="70" cy="70" r="35" fill="#fff"/>
  //       <circle cx="70" cy="70" r="28" fill="#0eae00"/>
  //     </g>
  //   </svg>
  // ''';

  // Future<Uint8List> _svgToPng() async {
  //   final PictureInfo pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);
  //   final recorder = ui.PictureRecorder();
  //   final canvas = Canvas(recorder);
  //   canvas.drawPicture(pictureInfo.picture);
  //   final ui.Image image = await pictureInfo.picture.toImage(70, 70);
  //   final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   pictureInfo.picture.dispose();
  //   return byteData!.buffer.asUint8List();
  // }

  // // void _addMarker() async {
  // //   final Uint8List markerIcon = await _svgToPng();
  // //   setState(() {
  // //     markers.add(Marker(
  // //       markerId: const MarkerId('marker1'),
  // //       position: const LatLng(37.43296265331129, -122.08832357078792),
  // //       icon: BitmapDescriptor.fromBytes(markerIcon),
  // //       onTap: () {
  // //         setState(() {
  // //           clickedMarkerID = 'marker1';
  // //           isMarkerClicked = !isMarkerClicked;
  // //         });
  // //       }
  // //     ));
  // //   });
  // // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get markers & convert to markers
    final placesList = ref.watch(placesRepositoryProvider).getPlacesList();

    // update the popup with marker if on marker click
    void onMarkerTap(id) {
      ref.read(targetPlaceProvider.notifier).setPlaceNumber(id);
    }

    final newMarkers = placesList.map((place) {
      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.lat, place.lng),
        onTap: () {
          onMarkerTap(place.id);
        }
      );
    }).toSet();
    const bool isMarkerClicked = true;
    // const String clickedMarkerID = '44';

    // Get popup data to display
    final targetPlace = ref.watch(targetPlaceProvider);
    final placeID = targetPlace['number'];

    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) {
                ref.read(mapCompleterProvider.notifier).addController(controller);
              },
              markers: newMarkers,
              mapType: MapType.normal, // hybrid, satellite, terrain
              onTap: (LatLng latLng) {
                // setState(() {
                //   isMarkerClicked = false;
                // });
              }
            ),
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for ( var i in [1, 2, 3, 4, 5, 6, 7] )
                      Padding(
                        padding: const EdgeInsets.all(10.0), // Add margin of 10.0 to all sides
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Text(
                              'child $i', // Concatenate 'i' with the string
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (isMarkerClicked)
            Positioned(
              bottom: 100,
              left: 5,
              right: 5,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    // popupId,
                    'Bottom Sheet Content $placeID',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Consumer(
              builder: (context, ref, _) {
                return FutureBuilder<GoogleMapController>(
                  future: ref.watch(mapCompleterProvider).future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const FloatingActionButton(
                        onPressed: null,
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return FloatingActionButton.extended(
                        onPressed: () async {
                          final GoogleMapController controller = snapshot.data!;
                          await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
                        },
                        label: const Text('To the lake!'),
                        icon: const Icon(Icons.directions_boat),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: () {
                // ref.read(placePopupRepositoryProvider).currentPopup = const Popup(placeID: '934');
                ref.read(targetPlaceProvider.notifier).setPlaceNumber(934);
              },
              label: const Text('+'),
              icon: const Icon(Icons.one_x_mobiledata),
            ),
          ),
        ]
      ),
    );
  }
}