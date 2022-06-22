import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:http/http.dart' as http;

import '../../../core/dictionaries/errors.dart';
import '../../../core/dictionaries/urls.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/random_api_model.dart';

class RandomApiData {
  /// Отправка токена приложения для пушей
  http.Client client = http.Client();

  Future<RandomApiModel> fetch({required int page, required int results}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try{
        final queryParams = {
          'page': '$page',
          'results': '$results',
        };

        Uri uri = Uri.https(Urls.srv, '/api/', queryParams);

        var re = await client.get(uri,
          headers: {
            'Content-Type': "application/json"
          },
        );

        log('${re.body}');

        if(re.statusCode == 200){
          final RandomApiModel body = RandomApiModel.fromJson(jsonDecode(utf8.decode(re.bodyBytes)));

          return body;
        } else if(re.statusCode == 401){
          throw UnAuthException(message: Errors.undefinedPerson);
        } else {
          throw ServerException(message: Errors.criticalServerErrorTitle);
        }
      } on SocketException catch(_){
        throw ConnectException(message: Errors.connectionFailed);
      } catch(_){
        rethrow;
      }
      finally{
        client.close();
      }
    } else {
      throw ConnectException(message: Errors.connectionFailed);
    }
  }
}