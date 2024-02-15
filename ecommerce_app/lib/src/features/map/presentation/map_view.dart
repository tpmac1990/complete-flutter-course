import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map'.hardcoded)),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194), // Initial map coordinates (San Francisco, CA)
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          // You can use the controller to interact with the map
          // For example, you can animate to a specific location:
          controller.animateCamera(
            CameraUpdate.newLatLng(
              const LatLng(37.7749, -122.4194)
            )
          );
        },
      ),
    );
  }
}
