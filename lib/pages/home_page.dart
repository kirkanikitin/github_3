import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

                  } else {

                  }
                  textController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add')
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
       backgroundColor: Colors.grey[350],
       centerTitle: true,
       title: const Text(
           'Заметки',
         style: TextStyle(
           fontWeight: FontWeight.w300,
         ),
       ),
     ),
      body: StreamBuilder<QuerySnapshot>(
        stream: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List noteList = snapshot.data!.docs;
            return ListView.builder(
                itemCount: null,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = noteList[index];
                  String docID = document.id;

                  Map<String, dynamic> data =
                      document.data() as  Map<String, dynamic>;
                  String noteText = data['info'];

                  return ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      children: [
                        IconButton(
                            onPressed: () => null,
                            icon: const Icon(Icons.settings)
                        ),
                        IconButton(
                            onPressed: () => null,
                            icon: const Icon(Icons.delete, color: Colors.redAccent)
                        ),
                      ],
                    ),
                  );
                }
            );
          } else {
            return const Text('Нету Заметок');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[350],
        elevation: 2,
        onPressed: () {
          
        },
        child: IconButton(
            onPressed: () {
              
            },
            icon: const Icon(
                Icons.add,
                color: Colors.grey
            ),
        ),
      ),    
    );
  }
}
