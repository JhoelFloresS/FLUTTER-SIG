import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final List<Polygon> polygons;

  const MapView({
    Key? key,
    required this.initialLocation,
    this.polygons = const [],
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 19,
        bearing: 65);

    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        compassEnabled: true,
        zoomGesturesEnabled: mapBloc.state.isOnViewWhole,
        scrollGesturesEnabled: mapBloc.state.isOnViewWhole,
        onMapCreated: ( controller ) async{
          mapBloc.add( OnMapInitialized(controller));
        },
        markers: Set<Marker>.of(mapBloc.state.markers),
        // geojson
        polygons: Set<Polygon>.of(polygons),
      ));
  }
}
