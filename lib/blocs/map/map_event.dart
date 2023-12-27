part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialized extends MapEvent {
  final GoogleMapController mapController;

  const OnMapInitialized(this.mapController);
}

class OnStartChargingPolygons extends MapEvent {}

class OnToggleViewCamera extends MapEvent {}

class OnNewResultsFound extends MapEvent{
  final List resultados;

  const OnNewResultsFound(this.resultados);
}

