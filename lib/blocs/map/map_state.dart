part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool followUser;
  final List<Polygon> polygons;
  final bool isPolygonCharged;
  final bool isOnViewWhole;

  const MapState({
    this.isMapInitialized = false,
    this.followUser = false,
    this.polygons = const [],
    this.isPolygonCharged = false,
    this.isOnViewWhole = false,
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
    List<Polygon>? polygons,
    bool? isPolygonCharged,
    bool? isOnViewWhole,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        followUser: followUser ?? this.followUser,
        polygons: polygons ?? this.polygons,
        isPolygonCharged: isPolygonCharged ?? this.isPolygonCharged,
        isOnViewWhole: isOnViewWhole ?? this.isOnViewWhole,
      );

  @override
  List<Object> get props => [isMapInitialized, followUser, polygons, isPolygonCharged, isOnViewWhole];
}
