import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_for_rubium/core/singletons/local_storage.dart';

import '../../../core/dictionaries/constants.dart';
import '../../../data/models/random_api_model.dart';
import '../../bloc/favorite_check_cubit/favorite_check_cubit.dart';
import 'geo_map.dart';

class UserInfo extends StatefulWidget {
  final Results user;

  const UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String login = LocalStorage.getString(AppConstants.LOGIN);

  @override
  void initState() {
    super.initState();
    if (checkCache()) {
      context.read<FavoriteCheckCubit>().changeFavorite(false);
    }
  }

  bool checkCache() {
    List<String> cache = LocalStorage.getList('${AppConstants.FAVORITES}$login');

    if (cache.isNotEmpty) {
      for (var element in cache) {
        if (widget.user == Results.fromJson(jsonDecode(element))) {
          return true;
        }
      }
    }
    return false;
  }

  void saveOrDeleteToCacheNewPerson() {
    List<String> cache = LocalStorage.getList('${AppConstants.FAVORITES}$login');
    List<Results> cacheResults = [];

    if (cache.isNotEmpty) {
      for (var element in cache) {
        cacheResults += [Results.fromJson(jsonDecode(element))];
      }

      bool doupletObjectFlag = false;

      for (var value in cacheResults) {
        if (widget.user == value) {
          doupletObjectFlag = true;
          cache.removeAt(cacheResults.indexOf(value));
          break;
        }
      }

      if (!doupletObjectFlag) {
        cache += [jsonEncode(widget.user)];
      }
      LocalStorage.setList('${AppConstants.FAVORITES}$login', cache);
    } else {
      LocalStorage.setList('${AppConstants.FAVORITES}$login', [jsonEncode(widget.user.toJson())]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Пользователь'),
      ),
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
      floatingActionButton: BlocBuilder<FavoriteCheckCubit, FavoriteCheckState>(
        builder: (context, state) {
          if (state is FavoriteCheckChangeState) {
            return FloatingActionButton(
              backgroundColor:
                  state.check ? Colors.cyan : Colors.lightBlueAccent,
              onPressed: () {
                context.read<FavoriteCheckCubit>().changeFavorite(!state.check);
                saveOrDeleteToCacheNewPerson();
              },
              child: Icon(
                Icons.favorite,
                color: state.check ? Colors.white : Colors.red,
                size: 30,
              ),
            );
          } else {
            return FloatingActionButton(
              backgroundColor: Colors.cyan,
              onPressed: () {
                context.read<FavoriteCheckCubit>().changeFavorite(false);
                saveOrDeleteToCacheNewPerson();
              },
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 30,
              ),
            );
          }
        },
      ),
    );
  }
}
