import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of notes from the database
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // CREATE
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  // SEARCH
  Stream<QuerySnapshot> searchNotes(String query) {
    return notes
        .where('note', isGreaterThanOrEqualTo: query)
        .where('note', isLessThanOrEqualTo: query + '\uf8ff')
        .orderBy('note')
        .snapshots();
  }

  // UPDATE
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
