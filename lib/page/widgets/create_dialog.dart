import 'package:flutter/material.dart';
import 'package:todo/model/todo_model.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({Key? key, this.todo}) : super(key: key);
  final TodoModel? todo;

  @override
  _CreateDialogState createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  late TextEditingController _title;
  late TextEditingController _desc;
  @override
  void initState() {
    _title = TextEditingController(text: widget.todo?.title);
    _desc = TextEditingController(text: widget.todo?.desc);
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.todo != null ? Text("EDIT") : Text("ADD"),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: _title,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.grey[200],
              filled: true,
              hintText: "Enter Title",
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: _desc,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.grey[200],
              filled: true,
              hintText: "Enter Description",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            "CANCEL",
          ),
        ),
        TextButton(
          onPressed: () {
            if (_desc.text.isEmpty || _title.text.isEmpty) {
              ScaffoldMessenger.maybeOf(context)
                ?..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
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
                          Text("Fill all values")
                        ])));
              return;
            }
            if (widget.todo != null) {
              Navigator.of(context).pop(widget.todo?.copyWith(
                title: _title.text.trim(),
                desc: _desc.text.trim(),
              ));
              return;
            }
            Navigator.of(context).pop(TodoModel(
              id: 1,
              title: _title.text.trim(),
              desc: _desc.text.trim(),
              complete: false,
            ));
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}
