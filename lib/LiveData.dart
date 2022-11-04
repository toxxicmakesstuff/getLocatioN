import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class LiveData extends StatefulWidget {
  const LiveData({super.key});

  @override
  State<LiveData> createState() => _LiveDataState();
}

class _LiveDataState extends State<LiveData> {
  String? currentLocation;
  GeoCode geoCode = new GeoCode();
  getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    try {
      var data = await geoCode.reverseGeocoding(
          latitude: _locationData.latitude!,
          longitude: _locationData.longitude!);

      String streetAddress = data.toString().split(",")[4].split("=")[1];
      String city = data.toString().split(",")[5].split("=")[1];
      String country = data.toString().split(",")[7].split("=")[1];

      setState(() {
        currentLocation = streetAddress + ", " + city + ", " + country;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 400,
          color: Colors.yellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    // ignore: avoid_print
                    print("Your Address is ");
                    getCurrentLocation();
                  },
                  icon: const Icon(Icons.room),
                  label: const Text("Location")),
              Text(
                currentLocation == null ? "-" : currentLocation!,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
