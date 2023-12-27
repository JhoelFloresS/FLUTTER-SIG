import 'dart:convert';

import 'package:app/providers/mercado.dart';
import 'package:app/themes/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:uuid/uuid.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  MercadoService mercadoService;


  List<Polygon> _polygons = [];
  GoogleMapController? _mapController;

  MapBloc({ required this.mercadoService}) : super(const MapState()) {
    on<OnMapInitialized>(_onInitMap);
    on<OnStartChargingPolygons>((event, emit) async {
      final List<Polygon> polygons = await loadPuestos();

      emit(state.copyWith(
        polygons: polygons,
        isPolygonCharged: true,
      ));
    });
    on<OnToggleViewCamera>(_handleToggeViewCamera);
    on<OnNewResultsFound>(_handleNewResultsFound);
  }

  void _onInitMap(OnMapInitialized event, Emitter<MapState> emit) async {
    _mapController = event.mapController;
    _mapController!.setMapStyle(jsonEncode(mainTheme));

    emit(state.copyWith(
      isMapInitialized: true,
    ));

    // final lines = <Polyline>[];
  }

  Future<List<Polygon>> loadPuestos() async {
    final geo = GeoJson();
    final data = await rootBundle.loadString('assets/puestos.json');
    await geo.parse(data, verbose: true);
    print('GeoJSON parsed ${geo.polygons}');

    for (var poly in geo.polygons) {
      final List<LatLng> points = poly.geoSeries[0].geoPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      _polygons.add(Polygon(
        polygonId: PolygonId(const Uuid().v4()),
        points: points,
        fillColor: Colors.grey.withOpacity(0.5),
        strokeWidth: 1,
      ));
    }
    return _polygons;
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: newLocation,
        zoom: 17,
      ),
    );
    _mapController?.animateCamera(cameraUpdate);
  }

  void _handleToggeViewCamera(
      OnToggleViewCamera event, Emitter<MapState> emit) {
    emit(state.copyWith(
      isOnViewWhole: !state.isOnViewWhole,
    ));
    
    if(state.isOnViewWhole){
         const marker = Marker(markerId: MarkerId("mercadito-marker"),
          position: LatLng(-17.725449054550545, -63.1480695049507),
          infoWindow: InfoWindow(
            title: "Mercado Nuevo Los Pozos"
          )
        );

      emit(state.copyWith(
        markers: [marker]
      ));
    } else {
      emit(state.copyWith(
        markers: []
      ));
    }
   
  }

  void _handleNewResultsFound(OnNewResultsFound event, Emitter<MapState> emit){
    emit(state.copyWith(resultados: event.resultados));

    final resultadosQ = event.resultados;
    const List<Marker> markers = [];
    for (var element in resultadosQ) {
      markers.add(
        Marker(markerId: MarkerId(const Uuid().v4()),
        position: LatLng(element["latitud"], element["longitud"]),
        infoWindow: InfoWindow(
          title: element["nombre_comercio"],
          snippet: element["direccion"]
        )
        )
      );
    }

    emit(state.copyWith(markers: markers));

  }

  void toggleMoveCamera() {
    final bool isOnViewWhole = state.isOnViewWhole;
    var cameraUpdate = null;
    if (!isOnViewWhole) {
      cameraUpdate = CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(-17.725449054550545, -63.14806950049507),
          zoom: 13,
        ),
      );

    } else {
      cameraUpdate = CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(-17.725449054550545, -63.14806950049507),
          zoom: 19,
          bearing: 65,
        ),
      );
    }

    add(OnToggleViewCamera());

    Future.delayed(Duration(milliseconds: 500))
        .then((_) {
          _mapController?.animateCamera(cameraUpdate);
          _mapController?.showMarkerInfoWindow(MarkerId("mercadito-marker"));
        });

    
  }


  void prueba() async {
    await mercadoService.searchStore("cajas");

  }

  void getResultsByQuery(String query) async {
    final resultados = await mercadoService.searchStore(query); 
    add( OnNewResultsFound( resultados ));
  }


}
