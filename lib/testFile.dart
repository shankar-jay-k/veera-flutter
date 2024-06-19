import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

 
class LocationDetails extends StatefulWidget {
  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  String _city = 'Unknown';
  List<Placemark> data = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue.
      return;
    }

    // Check for location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _city = 'Access denies';
        setState(() {

        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, don't continue.
      _city = 'Access denies';
      setState(() {

      });
      return;
    }

    // Get the current position.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print('Position:${position}');
    // Get the placemarks from the coordinates.
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print('place marks:${placemarks}');
    // If the placemarks list is not empty, get the city name.
    data = placemarks;
    setState(() {

    });
    if (placemarks.isNotEmpty) {
      setState(() {
        _city = placemarks[0].street ?? 'Unknown';
      });
      for (Placemark placemark in placemarks) {
        print('Name: ${placemark.name}');
        print('Street: ${placemark.street}');
        print('Locality: ${placemark.locality}');
        print('SubLocality: ${placemark.subLocality}');
        print('Postal Code: ${placemark.postalCode}');
        print('Administrative Area: ${placemark.administrativeArea}');
        print('Country: ${placemark.country}');
        // Add other properties as needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details of your location'),
      ),
      body: Center(
        child: data.length == 0 ?
        CircularProgressIndicator()
            : Container(
          width: MediaQuery.of(context).size.width * 0.52,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Name:',style: TextStyle(fontSize: 17),),
                    Text('${data[1].name}',style: TextStyle(fontSize: 17),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Street:',style: TextStyle(fontSize: 17),),
                    Text('${data[1].street}',style: TextStyle(fontSize: 17),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Locality:',style: TextStyle(fontSize: 17),),
                    Text('${data[1].locality}',style: TextStyle(fontSize: 17),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('SubLocality:',style: TextStyle(fontSize: 17),),
                    Text('${data[1].subLocality}',style: TextStyle(fontSize: 17),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Postal Code',style: TextStyle(fontSize: 17),),
                    Text(' ${data[1].postalCode}',style: TextStyle(fontSize: 17),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Administrative Area',style: TextStyle(fontSize: 17),),
                    Text(' ${data[1].administrativeArea}',style: TextStyle(fontSize: 17),),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('Country:',style: TextStyle(fontSize: 17),),
                    Text('${data[1].country}',style: TextStyle(fontSize: 17),),
                  ]),

            ],
          ),
        ),
      ),
    );
  }
}

