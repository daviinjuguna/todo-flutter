part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoRefreshing extends TodoState {}

class TodoSuccess extends TodoState {
  final List<TodoModel> todo;
  TodoSuccess({
    required this.todo,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoSuccess && listEquals(other.todo, todo);
  }

  @override
  int get hashCode => todo.hashCode;

  @override
  String toString() => 'TodoSuccess(todo: $todo)';
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  TodoError copyWith({
    String? message,
  }) {
    return TodoError(
      message ?? this.message,
    );
  }
}
