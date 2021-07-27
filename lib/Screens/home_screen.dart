import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crimemapping/Model/police_data_model.dart';
import 'package:crimemapping/Model/userclass.dart';
import 'package:crimemapping/Screens/profile_settings_screen.dart';
import 'package:crimemapping/services/service_police.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../palette.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';
import 'package:bottom_drawer/bottom_drawer.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'Home_Screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BitmapDescriptor customIcon1;
  final _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;
  UserProfile currentUser = UserProfile();
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
    setCustomMarker();
    getUserProfile().then((value) {
      setState(() {
        currentUser = value;
      });
    });
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

  Future<void> setCustomMarker() async {
    customIcon1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/badge_5.png');
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
    addMarkers();
    // addHeatmap();
    addLocation();

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.transparent,
      //   // backgroundColor: Color(0x44000000),
      //   elevation: 0,
      //   title: Text(
      //     mapToggle ? "loading.." : "Hello ${currentUser.name}",
      //     style: TextStyle(
      //         color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SafeArea(
        child: Stack(children: [
          Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xFFFC76A1))),
              onPressed: () {
                showModalBottomSheet<void>(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0))),
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) => showBottomSheet(),
                );
                // controller.open();
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
                  style: TextStyle(fontSize: 16, color: Color(0xFFFC76A1)),
                ),
              ),
              // icon: const Icon(Icons.dangerous),
              backgroundColor: Color(0xFF1D1D27),
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
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kSecondaryColor,
                  width: 1,
                ),
                color: kButtonBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  SPOT CRIME',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFC76A1),
                          fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton(
                      backgroundColor: kButtonBackground,
                      onPressed: () {
                        _showMyDialog();
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/background1.jpg'),
                        radius: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Profile',
          ),
          content: SingleChildScrollView(
              // child: ListBody(
              //   children: <Widget>[
              //     Image.asset('images/legend.png'),
              //   ],
              // ),
              child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/background1.jpg'),
                radius: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${currentUser.name}',
                  style: TextStyle(color: kSecondaryColor, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '${currentUser.email}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '${currentUser.phoneNo}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '${currentUser.homeAddress}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          )),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(color: kSecondaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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

  List<WeightedLatLng> _createPoints(LatLng location) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here
    points.add(_createWeightedLatLng(location.latitude, location.longitude, 1));

    return points;
  }

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }

  addMarkers() {
    for (var police in _policeMap) {
      LatLng point = LatLng(
          police.geometry.coordinates[0], police.geometry.coordinates[1]);
      setState(() {
        _markers.add(
          Marker(
            icon: customIcon1,
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

  String dropdownValue = 'Other';
  Widget showBottomSheet() {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  child: Text(
                    'Report An Issue',
                    style: TextStyle(color: kTextColor, fontSize: 32),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select Category',
                    style: TextStyle(color: kPrimaryColor, fontSize: 24),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 36,
                    elevation: 16,
                    style: const TextStyle(color: Color(0xFFFC76A1)),
                    underline: Container(
                      height: 2,
                      color: Color(0xFFC933EB),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Vandalism',
                      'Theft',
                      'Terrorism',
                      'Murder',
                      'Narcotics',
                      'Domestic abuse',
                      'Assault',
                      'Other'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 24),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Description',
                    style: TextStyle(color: kPrimaryColor, fontSize: 24),
                  ),
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '(Optional)',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF6F6F6), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: kSecondaryColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 5, //Normal textInputField will be displayed
                  maxLines: 5, // when user presses enter it will adapt to it
                ),
              ),
              FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xFFFC76A1))),
                onPressed: () {},
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'REPORT',
                    style: TextStyle(fontSize: 16, color: Color(0xFFFC76A1)),
                  ),
                ),
                backgroundColor: Color(0xFF1D1D27),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserProfile> getUserProfile() async {
    UserProfile user = UserProfile();
    final usersinfo = await _firestore.collection('user').get();
    for (var userinfo in usersinfo.docs) {
      if (userinfo.data()['email'] == loggedInUser.email) {
        // print(userinfo.data());
        user.name = userinfo['name'];
        user.email = userinfo['email'];
        user.phoneNo = userinfo['phoneNo'];
        user.emerPhoneNo = userinfo['emerPhoneNo'];
        user.homeAddress = userinfo['homeAddress'];
        user.gender = userinfo['gender'];
      }
    }
    print(user.homeAddress);
    return user;
  }
}
