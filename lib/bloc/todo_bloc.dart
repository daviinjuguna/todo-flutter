import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/repo/repository.dart';
import 'package:flutter/foundation.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial());
  late final _repo = Repository();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is TodoGet) {
      yield TodoLoading();
      final _res = await _repo.getTodos();
      yield _res.fold(
        (l) => TodoError(l),
        (todos) => TodoSuccess(todo: todos),
      );
    }
    if (event is TodoCreate) {
      yield TodoLoading();
      final _res = await _repo.createTodo(title: event.title, desc: event.desc);
      yield _res.fold(
        (l) => TodoError(l),
        (todo) => TodoSuccess(todo: [
          ...[todo],
          ...event.todo
        ]),
      );
    }
    if (event is TodoUpdate) {
      yield TodoLoading();
      final _res = await _repo.updateTodo(event.id, event.editedTodo);
      yield _res.fold(
        (l) => TodoError(l),
        (todo) {
          event.todo
            ..removeWhere((item) => item.id == event.id)
            ..insert(event.index, todo);

          return TodoSuccess(todo: event.todo);
        },
      );
    }
    if (event is TodoDelete) {
      yield TodoLoading();
      final _res = await _repo.deleteTodo(event.id);
      yield _res.fold(
        (l) => TodoError(l),
        (r) {
          event.todo..removeWhere((item) => item.id == event.id);
          return TodoSuccess(todo: event.todo);
        },
      );
    }
  }
}
