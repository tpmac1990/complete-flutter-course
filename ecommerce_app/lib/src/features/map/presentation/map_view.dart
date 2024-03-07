import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'dart:ui' as ui;

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late final Completer<GoogleMapController> _controller;
  late CameraPosition _currentCameraPosition;
  Set<Marker> markers = {};
  bool isMarkerClicked = false;
  String clickedMarkerID = '';
  List<int> text = [1, 2, 3, 4, 5, 6, 7];

  @override
  void initState() {
    super.initState();
    _controller = Completer<GoogleMapController>();
    _currentCameraPosition = _kGooglePlex;
  }

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

  final String svgString = '''
    <svg version="1.1" viewBox="0 0 70 70" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-35 -35)">
        <circle cx="70" cy="70" r="35" fill="#fff"/>
        <circle cx="70" cy="70" r="28" fill="#0eae00"/>
      </g>
    </svg>
  ''';

  Future<Uint8List> _svgToPng() async {
    final PictureInfo pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawPicture(pictureInfo.picture);
    final ui.Image image = await pictureInfo.picture.toImage(70, 70);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    pictureInfo.picture.dispose();
    return byteData!.buffer.asUint8List();
  }

  void _addMarker() async {
    final Uint8List markerIcon = await _svgToPng();
    setState(() {
      markers.add(Marker(
        markerId: const MarkerId('marker1'),
        position: const LatLng(37.43296265331129, -122.08832357078792),
        // infoWindow: const InfoWindow(title: 'San Francisco'),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: () {
          setState(() {
            clickedMarkerID = 'marker1';
            isMarkerClicked = !isMarkerClicked;
          });
        }
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
    _addMarker();
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _currentCameraPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
              markers: markers,
              mapType: MapType.normal, // hybrid, satellite, terrain
              onTap: (LatLng latLng) {
                setState(() {
                  isMarkerClicked = false;
                });
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
                    for ( var i in text )
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
                    'Bottom Sheet Content $clickedMarkerID',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
        ]
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: Sizes.p24, bottom: Sizes.p16),
          child: FloatingActionButton.extended(
            onPressed: _goToTheLake,
            label: const Text('To the lake!'),
            icon: const Icon(Icons.directions_boat),
          ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    setState(() {
      _currentCameraPosition = _kLake;
    });
  }
}