part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class TodoGet extends TodoEvent {}

class TodoRefresh extends TodoEvent {}

class TodoCreate extends TodoEvent {
  final List<TodoModel> todo;
  final String title;
  final String desc;
  TodoCreate({
    required this.todo,
    required this.title,
    required this.desc,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoCreate &&
        listEquals(other.todo, todo) &&
        other.title == title &&
        other.desc == desc;
  }

  @override
  int get hashCode => todo.hashCode ^ title.hashCode ^ desc.hashCode;

  @override
  String toString() => 'TodoCreate(todo: $todo, title: $title, desc: $desc)';
}

class TodoUpdate extends TodoEvent {
  final List<TodoModel> todo;
  final TodoModel editedTodo;
  final int id;
  final int index;
  TodoUpdate({
    required this.todo,
    required this.editedTodo,
    required this.id,
    required this.index,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoUpdate &&
        listEquals(other.todo, todo) &&
        other.editedTodo == editedTodo &&
        other.id == id &&
        other.index == index;
  }

  @override
  int get hashCode {
    return todo.hashCode ^ editedTodo.hashCode ^ id.hashCode ^ index.hashCode;
  }

  @override
  String toString() {
    return 'TodoUpdate(todo: $todo, editedTodo: $editedTodo, id: $id, index: $index)';
  }
}

class TodoDelete extends TodoEvent {
  final List<TodoModel> todo;
  final int id;
  TodoDelete({
    required this.todo,
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoDelete &&
        listEquals(other.todo, todo) &&
        other.id == id;
  }

  @override
  int get hashCode => todo.hashCode ^ id.hashCode;

  @override
  String toString() => 'TodoDelete(todo: $todo, id: $id)';
}
