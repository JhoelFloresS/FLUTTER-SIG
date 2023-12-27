import 'package:flutter/material.dart';

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
    return const Text('buildResults');
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
