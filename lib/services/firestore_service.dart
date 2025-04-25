import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/task_model.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String userEmail) {
    return _db
        .collection('tasks')
        .where('sharedWith', arrayContains: userEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Future<void> addTask(Task task) async {
    await _db.collection('tasks').doc(task.id).set(task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _db.collection('tasks').doc(task.id).update(task.toMap());
  }
  Future<void> deleteTask(Task task) async {
    await _db.collection('tasks').doc(task.id).delete();
  }
}