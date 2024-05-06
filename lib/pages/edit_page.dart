import 'package:flutter/material.dart';
import 'package:noteapp_sec/classes/status_check.dart';
import 'package:noteapp_sec/components/pop_up_message.dart';

class EditPage extends StatefulWidget {
  String titleText;
  String bodyText;
  Function(List) onChanged;
  EditPage({
    super.key,
    required this.titleText,
    required this.bodyText,
    required this.onChanged,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleContoller = TextEditingController();
  TextEditingController bodyContoller = TextEditingController();
  bool isUpdate = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleContoller.text = widget.titleText;
    bodyContoller.text = widget.bodyText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit page"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: titleContoller,
              maxLines: 2,
              maxLength: 80,
              decoration: InputDecoration(
                labelText: "title",
                hintText: titleContoller.text,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Body
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: bodyContoller,
              maxLines: 4,
              maxLength: 260,
              decoration: InputDecoration(
                // Text: "title",
                labelText: "Body Message",
                hintText: bodyContoller.text,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return ShowPopUp(
                      wrong: Icons.cancel_outlined,
                      subTitle: "Are you sure are you want to update",
                      // title1: "",
                    );
                  },
                );
                if (!StatusCheck.isUpdated) {
                  // Navigator.pop(context);
                  return;
                } else if (StatusCheck.isUpdated &&
                    titleContoller.text != "" &&
                    bodyContoller.text != "") {
                  widget.onChanged([titleContoller.text, bodyContoller.text]);
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => ShowPopUp(
                      subTitle: "Body or title is empty!",
                      title1: "Are you Understand",
                    ),
                  );
                  return;
                }
              },
              child: Text("Update"),
            ),
          ),
        ],
      ),
    );
  }
}
