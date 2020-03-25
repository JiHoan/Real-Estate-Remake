import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapPage extends StatefulWidget {
  @override
  _RouteMapPageState createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};

  List<Marker> markers = [
    Marker(
      markerId: MarkerId('marker 1'),
      draggable: false,
      onTap: () {
        print('marker 1');
      },
      position: LatLng(10.814081, 106.687123),
    ),
    Marker(
      markerId: MarkerId('marker 2'),
      draggable: false,
      onTap: () {
        print('marker 2');
      },
      position: LatLng(10.814172, 106.686555),
    ),
    Marker(
      markerId: MarkerId('marker 3'),
      draggable: false,
      onTap: () {
        print('marker 3');
      },
      position: LatLng(10.813738, 106.686752),
    ),
    Marker(
      markerId: MarkerId('marker 4'),
      draggable: false,
      onTap: () {
        print('marker 4');
      },
      position: LatLng(10.814065, 106.687298),
    ),
    Marker(
      markerId: MarkerId('marker 5'),
      draggable: false,
      onTap: () {
        print('marker 5');
      },
      position: LatLng(10.813695, 106.687168),
    ),
  ];

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    markers.map((data) {
      setState(() {
        _markers.add(
          Marker(
            markerId: data.markerId,
            draggable: true,
            onTap: data.onTap,
            position: data.position,
            icon: pinLocationIcon,
          ),
        );
      });
    }).toList();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100), devicePixelRatio: 2.5), 'assets/destination_map_marker.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(10.813981, 106.686689),
                zoom: 18,
              ),
              onMapCreated: _onMapCreated,
              markers: Set.from(_markers),
            ),
            Positioned(
              left: 5,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Color(0xffF8A200),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Material(
                textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                color: Color(0xff3FBF55),
                borderRadius: BorderRadius.circular(7),
                child: InkWell(
                  onTap: () {
                  },
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('54A Trần Bình Trọng, p5, Bình Thạnh'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
