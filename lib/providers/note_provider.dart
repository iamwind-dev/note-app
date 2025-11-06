import 'package:flutter/foundation.dart';
import '../models/note_model.dart';

/// Provider class that manages the state of all notes
/// Extends ChangeNotifier to notify listeners when notes change
class NoteProvider with ChangeNotifier {
  // Private list of notes
  final List<NoteModel> _notes = [];

  /// Public getter to access notes (unmodifiable)
  List<NoteModel> get notes => List.unmodifiable(_notes);

  /// Get total count of notes
  int get noteCount => _notes.length;

  /// Add a new note to the list
  /// Automatically generates a unique ID based on timestamp
  void addNote(String title, String content) {
    final note = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      dateTime: DateTime.now(),
    );
    
    _notes.insert(0, note); // Insert at beginning for newest first
    notifyListeners(); // Notify all listening widgets
  }

  /// Update an existing note
  /// Finds the note by ID and updates its fields
  void updateNote(String id, String title, String content) {
    final index = _notes.indexWhere((note) => note.id == id);
    
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(
        title: title,
        content: content,
        dateTime: DateTime.now(), // Update modification time
      );
      notifyListeners(); // Notify all listening widgets
    }
  }

  /// Delete a note by ID
  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners(); // Notify all listening widgets
  }

  /// Get a single note by ID
  NoteModel? getNoteById(String id) {
    try {
      return _notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search notes by title or content
  List<NoteModel> searchNotes(String query) {
    if (query.isEmpty) return notes;
    
    final lowerQuery = query.toLowerCase();
    return _notes.where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
             note.content.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Sort notes by date (newest first or oldest first)
  void sortByDate({bool ascending = false}) {
    if (ascending) {
      _notes.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    } else {
      _notes.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }
    notifyListeners();
  }

  /// Sort notes by title alphabetically
  void sortByTitle({bool ascending = true}) {
    if (ascending) {
      _notes.sort((a, b) => a.title.compareTo(b.title));
    } else {
      _notes.sort((a, b) => b.title.compareTo(a.title));
    }
    notifyListeners();
  }
}
