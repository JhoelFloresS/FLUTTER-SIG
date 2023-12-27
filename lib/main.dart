import 'package:app/blocs/blocs.dart';
import 'package:app/providers/mercado.dart';
import 'package:app/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:app/app.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => GpsBloc()),
      BlocProvider(create: (_) => LocationBloc()),
      BlocProvider(create: (_) => MapBloc( mercadoService: MercadoService())),
    ],
    child: const AppState(),
  ));
}

class AppState extends StatelessWidget {
  // const AppState({super.key});

  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapsApp',
      home: LoadigScreen()
    );
  }
}
