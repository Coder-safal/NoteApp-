import 'package:flutter/material.dart';
import 'package:noteapp_sec/classes/status_check.dart';
import 'package:noteapp_sec/components/pop_up_message.dart';

class AddNote extends StatefulWidget {
  Function(List) onChanged;
  AddNote({super.key, required this.onChanged});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isSubmit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddNote"),
        backgroundColor: Colors.orange[300],
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            // height: 300,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // title
              child: TextField(
                controller: titleController,
                maxLines: 2,
                maxLength: 60,
                // overflow: TextOverflow.ellipsis,
                decoration: InputDecoration(
                    hintText: "Flutter Learner",
                    labelText: "Add title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide())),
              ),
            ),
          ),

          // body
          SizedBox(height: 30),
          SizedBox(
            // height: 300,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: bodyController,
                maxLines: 5,
                maxLength: 260,
                decoration: InputDecoration(
                    hintText:
                        "I am flutter learn who is learning flutter .....",
                    labelText: "Add Body",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide())),
              ),
            ),
          ),
          // TextField(),

          // button

          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                print("add note submit");

                await showDialog(
                  context: context,
                  builder: (context) => ShowPopUp(
                    wrong: Icons.cancel_outlined,
                  ),
                );
                print("${StatusCheck.isSubbmitted} check the status");

                if (StatusCheck.isSubbmitted == false) {
                  // if users choose cancel
                  return;
                } else if (StatusCheck.isSubbmitted &&
                    titleController.text != "" &&
                    bodyController.text != "") {
                  widget.onChanged([titleController.text, bodyController.text]);
                  // widget.onChanged([titleController.text, bodyController.text]);
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => ShowPopUp(
                      title1: "Empty!",
                      subTitle: "Body or title is empty!",
                    ),
                  );
                  return;
                }
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
