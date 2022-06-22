import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_for_rubium/core/singletons/local_storage.dart';

import '../../../core/dictionaries/constants.dart';
import '../../../data/models/random_api_model.dart';
import 'geo_map.dart';

class UserInfo extends StatefulWidget {
  final Results user;

  const UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  void saveToCacheNewPerson() {
    List<String> cache = LocalStorage.getList(AppConstants.FAVORITES);
    List<Results> cacheResults = [];

    if (cache.isNotEmpty) {
      for (var element in cache) {
        cacheResults += [Results.fromJson(jsonDecode(element))];
      }

      bool doupletObjectFlag = false;

      for (var value in cacheResults) {
        if (widget.user == value) {
          doupletObjectFlag = true;
          break;
        }
      }

      if (!doupletObjectFlag) {
        cache += [jsonEncode(widget.user)];
        LocalStorage.setList(AppConstants.FAVORITES, cache);
      }
    } else {
      LocalStorage.setList(
          AppConstants.FAVORITES, [jsonEncode(widget.user.toJson())]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Column(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GeoMap(
                        coordinates: widget.user.location!.coordinates!,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                    widget.user.picture!.large!,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.user.name!.title} ${widget.user.name!.first} ${widget.user.name!.last}',
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${widget.user.location!.country}, ${widget.user.location!.city}, ${widget.user.location!.street!.number} ${widget.user.location!.street!.name}',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          saveToCacheNewPerson();
        },
        child: const Icon(
          Icons.favorite,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
