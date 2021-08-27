import 'package:dartz/dartz.dart';
import 'package:todo/api/api.dart';
import 'package:todo/model/todo_model.dart';

class Repository {
  late final _api = Api();

  Future<Either<String, List<TodoModel>>> getTodos() async {
    try {
      return right(await _api.getTodos());
    } catch (e) {
      return left("failed");
    }
  }

  Future<Either<String, TodoModel>> getSingleTodo(int id) async {
    try {
      return right(await _api.getTodoSingle(id));
    } catch (e) {
      return left("failed");
    }
  }

  Future<Either<String, TodoModel>> createTodo({
    required String title,
    required String desc,
  }) async {
    try {
      return right(await _api.createTodo(title: title, desc: desc));
    } catch (e) {
      return left("failed");
    }
  }

  Future<Either<String, TodoModel>> updateTodo(int id, TodoModel model) async {
    try {
      return right(await _api.updateToDo(id, model));
    } catch (e) {
      return left("failed");
    }
  }

  Future<Either<String, String>> deleteTodo(int id) async {
    try {
      return right(await _api.deleteToDo(id));
    } catch (e) {
      return left("failed");
    }
  }
}
