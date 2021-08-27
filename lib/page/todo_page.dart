import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/page/widgets/create_dialog.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final _bloc = TodoBloc();
  late List<TodoModel> _todos = const [];
  @override
  void initState() {
    super.initState();
    _bloc.add(TodoGet());
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _todos = state.todo;
          }
          if (state is TodoInitial) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
          if (state is TodoError) {
            ScaffoldMessenger.maybeOf(context)
              ?..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.fixed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "ERROR",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // SizedBox(height: 3),
                      Text("Something went wrong please try again")
                    ],
                  ),
                ),
              );
          }
          if (state is TodoLoading) {
            ScaffoldMessenger.maybeOf(context)
              ?..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("LOADING..."),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).colorScheme.background),
                      )
                    ],
                  ),
                ),
              );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text("HOME"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog<TodoModel?>(
              context: context,
              builder: (builder) => CreateDialog(),
            ).then((value) {
              if (value != null) {
                _bloc.add(TodoCreate(
                    todo: _todos, title: value.title, desc: value.desc));
              }
            }),
            child: Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: _todos.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, i) => ListTile(
              title: Text(_todos[i].title),
              subtitle: Text(_todos[i].desc),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => showDialog<TodoModel?>(
                      context: context,
                      builder: (builder) => CreateDialog(
                        todo: _todos[i],
                      ),
                    ).then((value) {
                      if (value != null) {
                        _bloc.add(
                          TodoUpdate(
                              todo: _todos,
                              editedTodo: value,
                              id: _todos[i].id,
                              index: i),
                        );
                      }
                    }),
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => showDialog<bool?>(
                      context: context,
                      builder: (builder) => AlertDialog(
                        title: Text("DELETE"),
                        content: Text("Are you sure you want to delete?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(null),
                            child: Text(
                              "CANCEL",
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(
                              "DELETE",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ).then((value) {
                      if (value != null && value) {
                        _bloc.add(TodoDelete(todo: _todos, id: _todos[i].id));
                      }
                    }),
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
