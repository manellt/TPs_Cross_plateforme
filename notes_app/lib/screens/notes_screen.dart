import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  // Sample initial notes data
  List<Map<String, dynamic>> notes = [
    {
      'id': '1',
      'content': 'Learn Flutter',
      'createdAt': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'content': 'Complete the tutorial',
      'createdAt': DateTime.now().toIso8601String(),
    },
  ];

  // Controller
  TextEditingController noteController = TextEditingController();

  // Note being edited
  Map<String, dynamic>? editingNote;

  // Add or update note
  void addNote() {

    if (noteController.text.trim().isEmpty) return;

    setState(() {

      if (editingNote != null) {

        // Update existing note
        for (int i = 0; i < notes.length; i++) {

          if (notes[i]['id'] == editingNote!['id']) {

            notes[i] = {
              ...notes[i],
              'content': noteController.text,
              'updatedAt': DateTime.now().toIso8601String(),
            };

            break;
          }
        }

        editingNote = null;

      } else {

        // Add new note
        final newNote = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': noteController.text,
          'createdAt': DateTime.now().toIso8601String(),
        };

        notes.insert(0, newNote);
      }
    });

    noteController.clear();

    Navigator.pop(context);
  }

  // Delete note
  void deleteNote(String id) {

    setState(() {
      notes.removeWhere(
        (note) => note['id'] == id,
      );
    });
  }

  // Edit note
  void editNote(Map<String, dynamic> note) {

    editingNote = note;

    noteController.text = note['content'];

    showNoteDialog();
  }

  // Show dialog
  void showNoteDialog() {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title: Text(
          editingNote != null
              ? 'Edit Note'
              : 'Add New Note',
        ),

        content: TextField(
          controller: noteController,

          decoration: const InputDecoration(
            hintText: 'Enter your note here...',
            border: OutlineInputBorder(),
          ),

          maxLines: 5,
          autofocus: true,
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),

          TextButton(
            onPressed: addNote,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [

          // Header
          Container(
            height: 100,
            color: Colors.blue,

            padding: const EdgeInsets.only(
              bottom: 15,
              left: 20,
              right: 20,
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  'My Notes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Add button
                InkWell(
                  onTap: () {

                    editingNote = null;

                    noteController.clear();

                    showNoteDialog();
                  },

                  child: Container(
                    width: 36,
                    height: 36,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(18),
                    ),

                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Notes list
          Expanded(

            child: notes.isNotEmpty

                ? ListView.builder(

                    padding:
                        const EdgeInsets.all(15),

                    itemCount: notes.length,

                    itemBuilder:
                        (context, index) {

                      final note = notes[index];

                      return Container(

                        margin:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(8),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1),
                              blurRadius: 4,
                              offset:
                                  const Offset(0, 2),
                            ),
                          ],
                        ),

                        child: Padding(
                          padding:
                              const EdgeInsets.all(15),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                note['content'],
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,

                                children: [

                                  TextButton(
                                    onPressed: () =>
                                        editNote(note),

                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),

                                  TextButton(
                                    onPressed: () =>
                                        deleteNote(
                                            note['id']),

                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )

                : const Center(
                    child: Text(
                      'No notes yet. Create one!',
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            Color(0xFF7F8C8D),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {

    noteController.dispose();

    super.dispose();
  }
}