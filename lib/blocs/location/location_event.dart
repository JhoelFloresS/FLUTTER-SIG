part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}


class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;

  const OnNewUserLocationEvent(this.newLocation);

  @override
  List<Object> get props => [newLocation];
}

class OnStartFollowingUser extends LocationEvent {}
class OnStopFollowingUser extends LocationEvent {}