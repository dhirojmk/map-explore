import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      debugShowCheckedModeBanner: false,
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.28322066830238, 85.84283754229546),
    zoom: 14.4746,
  );

  static const Marker _kGoogleplexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(20.28322066830238, 85.84283754229546),
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(19.743443870667424, 85.36067694425583),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  static final Marker _kLakeMarker = Marker(
    markerId: const MarkerId('_kLakeMarker'),
    infoWindow: const InfoWindow(title: 'Lake '),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: const LatLng(19.743443870667424, 85.36067694425583),
  );

  static const Polyline _kPolyline = Polyline(
    polylineId: PolylineId('_kPolyline'),
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
    ],
    width: 3,
  );

  static const Polygon _kPolygon = Polygon(
    polygonId: PolygonId('_kPolygon'),
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.418, -122.092),
      LatLng(37.435, -122.092),
    ],
    strokeWidth: 3,
    fillColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leading: PopupMenuButton<int>(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
            size: 27,
          ),
          onSelected: (item) => _onSelected(context, item),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.emergency_share, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Emergency Share'),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.gps_fixed_outlined, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Gps'),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  Icon(Icons.map, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Your Data In map'),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.traffic, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Traffic'),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 4,
              child: Row(
                children: [
                  Icon(Icons.location_city, color: Colors.black),
                  SizedBox(width: 8),
                  Text('LocationCity'),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 5,
              child: Row(
                children: [
                  Icon(Icons.update, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Update'),
                ],
              ),
            ),
          ],
        ),
        title: const Text(
          'Map Explorer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.black,
              size: 27,
            ),
            onSelected: (item) => _onAccountSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 27,
            ),
            onSelected: (item) => _onSettingsSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.security, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Security'),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.notifications, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Notifications'),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.language, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Language'),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.help, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Help'),
                  ],
                ),
              ),
            ],
          ),
        ],
        elevation: 10.0,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                  child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Search by City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[2000],
                      contentPadding: const EdgeInsets.only(
                        left: 20.0, // Add padding from the left
                        top: 13.0,
                        bottom: 18.0,
                        right: 20.0,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 17.0), // Add right padding to the icon
                        child: IconButton(
                          onPressed: () async {
                            var place = await LocationService().getPlace(_searchController.text);
                            _goToPlace(place);
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {
                _kGoogleplexMarker, //_kLakeMarker
              },
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('Emergency Share clicked');
        break;
      case 1:
        print('Gps clicked');
        break;
      case 2:
        print('Your Data In map clicked');
        break;
      case 3:
        print('Traffic clicked');
        break;
      case 4:
        print('LocationCity clicked');
        break;
      case 5:
        print('Update clicked');
        break;
    }
  }

  void _onAccountSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('Profile clicked');
        break;
      case 1:
        print('Logout clicked');
        break;
    }
  }

  void _onSettingsSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        print('Security clicked');
        break;
      case 1:
        print('Notifications clicked');
        break;
      case 2:
        print('Language clicked');
        break;
      case 3:
        print('Help clicked');
        break;
    }
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }
}
