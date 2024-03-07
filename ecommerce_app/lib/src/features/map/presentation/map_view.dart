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
    <svg version="1.1" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
      <g transform="translate(-32 -32)">
        <circle cx="64" cy="64" r="32" fill="#fff"/>
        <circle cx="64" cy="64" r="26" fill="#0eae00"/>
      </g>
    </svg>
  ''';

  Future<Uint8List> _svgToPng() async {
    final PictureInfo pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawPicture(pictureInfo.picture);
    final ui.Image image = await pictureInfo.picture.toImage(64, 64);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    pictureInfo.picture.dispose();
    return byteData!.buffer.asUint8List();
  }

  void _addMarker() async {
    final Uint8List markerIcon = await _svgToPng();
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('marker1'),
        position: LatLng(37.43296265331129, -122.08832357078792),
        infoWindow: InfoWindow(title: 'San Francisco'),
        icon: BitmapDescriptor.fromBytes(markerIcon),
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
      appBar: AppBar(title: Text('Map'.hardcoded)),
      body: Container(
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
        ),
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