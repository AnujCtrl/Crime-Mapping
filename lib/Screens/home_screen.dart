import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../palette.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'Home_Screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool mapToggle = false;
  GoogleMapController myController;
  // var currentLocation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Geolocator.getCurrentPosition().then((currloc) {
    //   setState(() {
    //     currentLocation = currloc;
    //     mapToggle = true;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
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
        iconTheme: IconThemeData(color: kSecondaryTextColor),
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(
          "Hello User",
          style: TextStyle(color: kSecondaryTextColor),
        ),
      ),
      body: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed:
              // showModalBottomSheet<void>(
              //   context: context,
              //   builder: (BuildContext context) => showBottomSheet(),
              // );
              myController == null
                  ? null
                  : () =>
                      myController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(42.3601, -71.0589),
                            zoom: 16.0,
                            tilt: 30),
                      )),

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
            child: GoogleMap(
          onMapCreated: (controller) {
            setState(() {
              myController = controller;
            });
          },
          compassEnabled: true,
          initialCameraPosition:
              CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 10.0),
        )
            // : Center(
            //     child: Text(
            //       'Loading...',
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   ),
            ),
      ),
    );
  }

  Widget showBottomSheet() {
    return Container();
  }
}
