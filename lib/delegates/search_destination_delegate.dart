import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDestinationDelegate extends SearchDelegate {
  SearchDestinationDelegate()
      : super(
          searchFieldLabel: 'Buscar...',
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    
    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.getResultsByQuery(query);
    
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        final resultados = state.resultados;

        return ListView.separated(
          itemCount: resultados.length,
          itemBuilder: (context, i ){
            final resultado = resultados[i];
            return ListTile(
              title: Text( resultado["nombre_comercio"]),
              subtitle: Text( resultado["direccion"]),
              leading: const Icon( Icons.production_quantity_limits_rounded),
            );
          },
          separatorBuilder: ( context, i) => const Divider(),
        );
      } 
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Colocar ubicación manualmente'),
          onTap: () {
            print('Manualmente');
            close(context, null);
          },
        ),
        ListTile(
          leading: const Icon(Icons.place),
          title: const Text('Colocar ubicación en el mapa'),
          onTap: () {
            print('En el mapa');
            close(context, null);
          },
        ),
      ],
    );
  }
}
