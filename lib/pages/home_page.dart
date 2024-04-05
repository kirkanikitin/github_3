import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:github_3/logic/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Firestore firestore = Firestore();
  final textController = TextEditingController();

  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      if (docID == null) {
                        firestore.addNote(textController.text);
                      } else {
                        firestore.updateNote(docID, textController.text);
                      }
                      textController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Add'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey[600]),
        title: const Text(
          'Заметки',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List noteList = snapshot.data!.docs;
            return ListView.builder(
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = noteList[index];
                  String docID = document.id;

                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(noteText),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () => openNoteBox(docID: docID),
                                icon: const Icon(Icons.settings)),
                            IconButton(
                                onPressed: () => firestore.deleteNote(docID),
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Text('Нету Заметок');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[350],
        elevation: 2,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.grey),
      ),
    );
  }
}
