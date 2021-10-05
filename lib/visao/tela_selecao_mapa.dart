import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:location/location.dart';

class TelaSelecaoMapa extends StatefulWidget {
  final Function _onFinishedSelection;

  TelaSelecaoMapa(this._onFinishedSelection(double latitude, double longitude));

  @override
  _TelaSelecaoMapaState createState() => _TelaSelecaoMapaState(this._onFinishedSelection);
}

class _TelaSelecaoMapaState extends State<TelaSelecaoMapa> {
  final Function _onFinishedSelection;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? gMapController;
  Set<Marker> markers = Set<Marker>();
  Set<Circle> circles = Set<Circle>();

  _TelaSelecaoMapaState(this._onFinishedSelection);

  @override
  void initState() {
    super.initState();
  }

  String generateUniqueID() {
    return Uuid().v4();
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  Future<CameraPosition> getCurrentLocationCameraPosition() async {
    var locationData = await getCurrentLocation();
    return CameraPosition(
        bearing: 0,
        target: LatLng(locationData!.latitude!, locationData.longitude!),
        // tilt: 59.440717697143555,
        tilt: 65,
        zoom: 19.151926040649414);
  }

  Widget _appBarTitle = Text("Geolocalização do Local");
  Widget buildBar(BuildContext context) {
    return new AppBar(backgroundColor: Color(0xff819CA9), centerTitle: true, title: _appBarTitle);
  }

//Construtor da Barra de Rodapé
//cor padrao dos icones de rodape > 0xfff819CA9
  Widget buildBottonBar(BuildContext context) {
    return new BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Color(0xfff29434e),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: Color(0xfff29434e),
            ),
            onPressed: () {},
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Color(0xfff819CA9),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future _addMarkerLongPressed(LatLng latlang) async {
      setState(() {
        final MarkerId markerId = MarkerId(generateUniqueID());
        Marker marker = Marker(
          markerId: markerId,
          draggable: true,
          position: latlang,
          icon: BitmapDescriptor.defaultMarker,
        );

        markers.clear();
        markers.add(marker);

        circles.clear();
        circles.add(Circle(
          circleId: CircleId(generateUniqueID()),
          fillColor: Color.fromRGBO(144, 202, 249, 0.4),
          strokeColor: Colors.black,
          strokeWidth: 2,
          center: latlang,
          radius: 15,
        ));
      });

      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(latlang));
    }

    if (circles.length > 0) {
      var circle = Circle(
        circleId: CircleId(generateUniqueID()),
        fillColor: circles.last.fillColor,
        strokeColor: circles.last.strokeColor,
        strokeWidth: circles.last.strokeWidth,
        center: circles.last.center,
        radius: 15,
      );
      circles.clear();
      circles.add(circle);
    }

    return new Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Geolocalização do Local")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffF50057),
        child: Icon(Icons.check),
        onPressed: () {
          if (this.markers.length > 0) {
            Marker marker = markers.last;
            this._onFinishedSelection(marker.position.latitude, marker.position.longitude);
            Navigator.of(context).pop();
          } else {
            showDialog(
              context: context,
              builder: (BuildContext builder) {
                return new AlertDialog(
                  title: new Text("Atenção"),
                  content: Text("Selecione um ponto no mapa", textAlign: TextAlign.center),
                  actions: <Widget>[
                    new TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                );
              },
            );
          }
        },
      ),
      body: FutureBuilder<CameraPosition>(
        future: getCurrentLocationCameraPosition(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            CameraPosition _myLocation = snapshot.data;

            return Column(
              children: <Widget>[
                Expanded(
                    child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _myLocation,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    gMapController = controller;
                  },
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: true,
                  compassEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onLongPress: (latlang) {
                    _addMarkerLongPressed(latlang);
                  },
                  markers: markers,
                  circles: circles,
                )),
              ],
            );
          }
          return Center(child: Text("Carregando mapa..."));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottonBar(context),
    );
  }
}
