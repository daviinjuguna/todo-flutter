import 'dart:convert';

import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http/http.dart' as http;
import 'package:todo/model/todo_model.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/http_interceptors.dart';

class Api {
  http.Client _client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
      HeadersInterceptors(),
    ],
    requestTimeout: Duration(seconds: 60),
  );

  Uri appUrl(String url, [Map<String, dynamic>? queryParameters]) =>
      Uri.http(BASE_URL, url, queryParameters);

  Future<List<TodoModel>> getTodos() async {
    try {
      final _url = "/todo/todo-list/";
      final _res = await _client.get(appUrl(_url));
      if (_res.statusCode != 200) throw Exception();
      final Map<String, dynamic> _body = jsonDecode(_res.body);
      // if ((_body as List).isEmpty) return [];
      return (_body['todo'] as List).map((e) => TodoModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<TodoModel> getTodoSingle(int id) async {
    try {
      final _url = "/todo/todo-detail/$id/";
      final _res = await _client.get(appUrl(_url));
      if (_res.statusCode != 200) throw Exception();
      final Map<String, dynamic> _body = jsonDecode(_res.body);
      return TodoModel.fromJson(_body);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<TodoModel> createTodo({
    required String title,
    required String desc,
  }) async {
    try {
      final _url = "/todo/todo-create/";
      final _res = await _client.post(appUrl(_url),
          body: jsonEncode({"title": title, "description": desc}));
      if (_res.statusCode != 200) throw Exception();
      final Map<String, dynamic> _body = jsonDecode(_res.body);
      return TodoModel.fromJson(_body);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<TodoModel> updateToDo(int id, TodoModel model) async {
    try {
      final _url = "/todo/todo-update/$id/";
      final _res = await _client.post(appUrl(_url), body: model.toJson());
      if (_res.statusCode != 200) throw Exception();
      final Map<String, dynamic> _body = jsonDecode(_res.body);
      return TodoModel.fromJson(_body);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<String> deleteToDo(int id) async {
    try {
      final _url = "/todo/todo-delete/$id/";
      final _res = await _client.delete(appUrl(_url));
      if (_res.statusCode != 200) throw Exception();
      final Map<String, dynamic> _body = jsonDecode(_res.body);
      return _body as String;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
