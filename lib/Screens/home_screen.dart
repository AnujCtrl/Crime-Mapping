import 'package:crimemapping/Model/police_data_model.dart';
import 'package:crimemapping/Screens/Profile/profile_settings_screen.dart';
import 'package:crimemapping/services/service_police.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../palette.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'Home_Screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;

  List<Feature> _policeMap = List<Feature>();
  final Set<Heatmap> _heatmaps = {};
  final Set<Marker> _markers = {};
  LatLng _heatmapLocation = LatLng(9.0820, 8.6753);
  String _mapStyle;
  bool mapToggle;
  GoogleMapController myController;
  // var currentLocation;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    mapToggle = true;
    ServicesPoliceMap.getPoliceMap().then((value) {
      setState(() {
        _policeMap = value;
        mapToggle = false;
      });
    });

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    // Geolocator.getCurrentPosition().then((currloc) {
    //   setState(() {
    //     currentLocation = currloc;
    //     mapToggle = true;
    //   });
    // });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // addMarkers();
    // addHeatmap();
    addLocation();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: kGradientColor,
                ),
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),
            ListTile(
              title: Text('Theme'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: kPrimaryTextColor),
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(
          mapToggle ? "loading.." : "Hello User",
          style: TextStyle(
              color: kPrimaryTextColor,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
        Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) => showBottomSheet(),
              );
            },
            // myController == null
            //     ? null
            //     : () => myController
            //             .animateCamera(CameraUpdate.newCameraPosition(
            //           CameraPosition(
            //               target: LatLng(42.3601, -71.0589),
            //               zoom: 16.0,
            //               tilt: 30),
            //         )),

            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'REPORT AN ISSUE',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // icon: const Icon(Icons.announcement_rounded),
            backgroundColor: Colors.red,
          ),
          bottomNavigationBar: BottomAppBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Container(
              child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            heatmaps: _heatmaps,
            onMapCreated: (controller) {
              controller.setMapStyle(_mapStyle);
              setState(() {
                myController = controller;
                myController.setMapStyle(_mapStyle);
              });
            },
            markers: _markers,
            compassEnabled: true,
            initialCameraPosition:
                CameraPosition(target: _heatmapLocation, zoom: 10.0),
          )
              // : Center(
              //     child: Text(
              //       'Loading...',
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ),
              ),
        ),
        ClipPath(
          child: Opacity(
            opacity: 0.9,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 145,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: kGradientColor)),
            ),
          ),
          clipper: CustomClipPath(),
        )
      ]),
    );
  }

  void addHeatmap() {
    for (var police in _policeMap) {
      LatLng point = LatLng(police.geometry.coordinates[0] - 0.1,
          police.geometry.coordinates[1] + 0.1);
      setState(() {
        _heatmaps.add(Heatmap(
            heatmapId: HeatmapId(police.properties.id.toString()),
            points: _createPoints(LatLng(point.latitude, point.longitude)),
            radius: 20,
            visible: true,
            gradient: HeatmapGradient(
                colors: <Color>[Colors.green, Colors.red],
                startPoints: <double>[0.2, 0.8])));
      });
    }
  }

  //heatmap generation helper functions
  List<WeightedLatLng> _createPoints(LatLng location) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));
    // points.add(
    //     _createWeightedLatLng(location.latitude - 1, location.longitude, 1));
    // print(points.toList());
    return points;
  }

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    //print(WeightedLatLng(point: LatLng(lat, lng), intensity: weight));
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }

  addMarkers() {
    for (var police in _policeMap) {
      LatLng point = LatLng(
          police.geometry.coordinates[0], police.geometry.coordinates[1]);
      setState(() {
        _markers.add(
          Marker(
            position: LatLng(point.latitude, point.longitude),
            markerId: MarkerId(police.properties.id.toString()),
            infoWindow: InfoWindow(
                title: police.properties.name,
                snippet: police.properties.stateName
                    .toString()
                    .replaceAll('StateName.', 'State: ')),
            onTap: () {},
          ),
        );
      });
    }
  }

  addLocation() {
    setState(() {
      _markers.add(
        Marker(
          // icon: Icon(location),
          position: LatLng(
              _heatmapLocation.latitude - 0.1, _heatmapLocation.longitude),
          markerId: MarkerId('Your Location'),
          infoWindow: InfoWindow(
            title: 'Your Location',
          ),
          onTap: () {},
        ),
      );
    });
  }

  Widget showBottomSheet() {
    return Container();
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 2.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
