import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/random_api_model.dart';

class FavoriteUsers extends StatefulWidget {
  final List<Results> usersFavorite;

  const FavoriteUsers({Key? key, required this.usersFavorite}) : super(key: key);

  @override
  State<FavoriteUsers> createState() => _FavoriteUsersState();
}

class _FavoriteUsersState extends State<FavoriteUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Избранное'),
      ),
      body: ListView.builder(
        itemCount: widget.usersFavorite.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue.withOpacity(0.5),
              child: ListTile(
                leading: Hero(
                  tag: '$index',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.usersFavorite[index].picture!.medium!,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      '${widget.usersFavorite[index].name!.first} ${widget.usersFavorite[index].name!.last}',
                    ),
                  ],
                ),
                trailing: const Icon(Ionicons.information_circle),
              ),
            ),
          );
        },
      ),
    );
  }
}
