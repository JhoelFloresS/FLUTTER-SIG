import "package:app/blocs/blocs.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_speed_dial/flutter_speed_dial.dart";

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.blue[100],
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.share_location_rounded,
            color: Colors.black87,
          ),
          onPressed: () {
            mapBloc.toggleMoveCamera();
            // }
          },
        ),
      ),
    );
  }
}
