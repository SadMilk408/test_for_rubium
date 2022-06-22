import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:test_for_rubium/presentation/bloc/favorite_check_cubit/favorite_check_cubit.dart';

import '../../../core/dictionaries/constants.dart';
import '../../../core/singletons/local_storage.dart';
import '../../../data/models/random_api_model.dart';
import '../../bloc/all_users_bloc/all_users_bloc.dart';
import '../authorization/auth.dart';
import '../favorite_users/favorite_users.dart';
import '../user_info_page/user_info.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  late List<Results> users;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int pageCount = 1;

  Future<void> _onRefresh() async {
    context
        .read<AllUsersBloc>()
        .add(AllUsersLoadingEvent(page: 1, results: 20));
  }

  @override
  void initState() {
    super.initState();

    void scrollListener() async {
      if (scrollController.position.extentAfter < 150 && !isLoading) {
        isLoading = true;
        context.read<AllUsersBloc>().add(AllUsersAddElementsEvent(
            page: pageCount, results: 10, oldList: users));
        pageCount += 1;
        await Future.delayed(const Duration(seconds: 1));
        isLoading = false;
      }
    }

    scrollController.addListener(scrollListener);
  }

  getUsersFromCache() {
    String login = LocalStorage.getString(AppConstants.LOGIN);
    List<Results> usersFavorite = [];
    List<String> cache = LocalStorage.getList('${AppConstants.FAVORITES}$login');

    if (cache.isNotEmpty) {
      for (var element in cache) {
        usersFavorite.add(Results.fromJson(jsonDecode(element)));
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FavoriteUsers(
          usersFavorite: usersFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          onPressed: () {
            LocalStorage.remove(AppConstants.LOGIN);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AuthPage(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(users: users),
              );
            },
            icon: const Icon(Ionicons.search),
          ),
        ],
        title: Text(LocalStorage.getString(AppConstants.LOGIN)),
      ),
      body: listOfUsers(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          getUsersFromCache();
        },
        child: const Icon(
          Icons.star,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget listOfUsers() {
    return BlocBuilder<AllUsersBloc, AllUsersState>(builder: (context, state) {
      if (state is AllUsersLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is AllUsersFailedState) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is AllUsersNetworkExceptionState) {
        return const Center(
          child: Text('Нет подключения к сети'),
        );
      } else if (state is AllUsersDoneState) {
        users = state.users;

        if (users.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: scrollController,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => FavoriteCheckCubit(),
                            child: UserInfo(
                              user: users[index],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.blue.withOpacity(0.5),
                      child: ListTile(
                        leading: Hero(
                          tag: '$index',
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              users[index].picture!.medium!,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              '${users[index].name!.first} ${users[index].name!.last}',
                            ),
                          ],
                        ),
                        trailing: const Icon(Ionicons.information_circle),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      } else {
        return const Center(
          child: Text('Нет сигналов'),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class MySearchDelegate extends SearchDelegate {
  final List<Results> users;
  late List<Results> searchResultUsers = [...users];

  MySearchDelegate({required this.users});

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: const Icon(Ionicons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
    return null;
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Ionicons.close),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Results> users = searchResultUsers.where((searchResult) {
      final result =
          '${searchResult.name!.first!.toLowerCase()} ${searchResult.name!.last!.toLowerCase()}';
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                query =
                    '${users[index].name!.first} ${users[index].name!.last}';
              },
              child: Container(
                color: Colors.blue.withOpacity(0.5),
                child: ListTile(
                  leading: Hero(
                    tag: '$index',
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        users[index].picture!.medium!,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        '${users[index].name!.first} ${users[index].name!.last}',
                      ),
                    ],
                  ),
                  trailing: const Icon(Ionicons.information_circle),
                ),
              ),
            ),
          );
        });
  }
}
