import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dictionaries/constants.dart';
import '../../../core/dictionaries/errors.dart';
import '../../../core/singletons/local_storage.dart';
import '../../bloc/all_users_bloc/all_users_bloc.dart';
import '../all_users/all_users.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _login = TextEditingController();

  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              child: Form(
                key: _formKeyLogin,
                child: TextFormField(
                  controller: _login,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.black12,
                      labelText: 'Логин',
                      filled: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Errors.requiredField;
                    }
                    return null;
                  },
                ),
              ),
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  if (_formKeyLogin.currentState!.validate()) {
                    LocalStorage.setString(
                        AppConstants.LOGIN, _login.text.trim());
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => AllUsersBloc()
                              ..add(AllUsersLoadingEvent(page: 1, results: 20)),
                          ),
                        ],
                        child: AllUsers(),
                      ),
                    ));
                  }
                },
                child: Container(
                  width: 200,
                  height: 60,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
