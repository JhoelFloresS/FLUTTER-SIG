import 'package:app/blocs/blocs.dart';
import 'package:app/views/views.dart';
import 'package:app/widgets/btn_location.dart';
import 'package:app/widgets/btn_toggleView.dart';
import 'package:app/widgets/btn_tracking.dart';
import 'package:app/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LocationBloc locationBloc;
  late MapBloc mapBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);

    mapBloc.add(OnStartChargingPolygons());

    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Tu Aplicación'),
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     _buildSearchField(),
      //     // IconButton(
      //     //   icon: const Icon(Icons.search),
      //     //   onPressed: () {
      //     //     print('Click en buscar');
      //     //   },
      //     // ),
      //   ],
      // ),
      // body: const Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     // Aquí puedes poner tu imagen
      //     Image(image: AssetImage('assets/planolospozosleyenda.png')),
      //   ],
      // ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.lastKnowLocation == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
            if (!state.isPolygonCharged) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation:
                        const LatLng(-17.725449054550545, -63.14806950049507),
                      polygons: state.polygons,
                    ),

                    const SearchBarWidget(),
                  ],
                )
            );
          });
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.ac_unit),
      //         onPressed: () {
      //           // Acción para el primer botón
      //         },
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.access_alarm),
      //         onPressed: () {
      //           // Acción para el segundo botón
      //         },
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.accessible),
      //         onPressed: () {
      //           // Acción para el tercer botón
      //         },
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.account_balance),
      //         onPressed: () {
      //           // Acción para el cuarto botón
      //         },
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.account_box),
      //         onPressed: () {
      //           // Acción para el quinto botón
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.,
        // crossAxisAlignment: CrossAxisAlignment.end,
        // verticalDirection: VerticalDirection.up,
        children: [
          SpeedDial(
            // animatedIcon: AnimatedIcons.menu_close,
            icon: Icons.arrow_circle_up_outlined,
            activeIcon: Icons.close,
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            mini: true,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.shopping_bag_outlined),
                label: 'Buscar Producto',
                onTap: () {
                  mapBloc.prueba();
                }
              ),
              SpeedDialChild(
                child: const Icon(Icons.shopping_cart_outlined),
                label: 'Buscar Puesto',
              ),
            ],
          ),
          const BtnToogleView(),
          const BtnCurrentLocation(),
          const BtnTracking()
        ],
      ),
    );
  }
}

Widget _buildSearchField() {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // color: Colors.white,
      child: const TextField(
        decoration: InputDecoration(
          //border rounded
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          hintText: 'Buscar...',
          fillColor: Colors.white,
          filled: true,
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
