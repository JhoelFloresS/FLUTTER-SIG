import 'package:app/blocs/blocs.dart';
import 'package:app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadigScreen extends StatelessWidget {
  const LoadigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
            ? const HomeScreen()
            : const GpsAccesScreen();
        },
      )
    );
  }
}
