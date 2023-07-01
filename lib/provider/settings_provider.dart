import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/user_dm.dart';
import '../model/todo_dm.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLocal ;
  bool isDarkMode;
  ThemeMode currentTheme ;
  DateTime selectedDate = DateTime.now();
  List<TodoDM> todosList = [];

  SettingsProvider({required this.currentLocal,required this.isDarkMode,required this.currentTheme});


  changeCurrentLocal({required String languageSelected}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(languageSelected=="en"){
      currentLocal = languageSelected;
      await prefs.setString('isLanguageEnglish', "en");
    }else{
      currentLocal = languageSelected;
      await prefs.setString('isLanguageEnglish', "ar");
    }
    notifyListeners();
  }

  changeCurrentTheme({required ThemeMode newTheme}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(newTheme==ThemeMode.dark){
      currentTheme = newTheme;
      await prefs.setBool('isDarkMode', true);

    }else{
      currentTheme = newTheme;
      await prefs.setBool('isDarkMode', false);
    }
    notifyListeners();
  }

  refreshTodosFromFirestore() {
    var todos = FirebaseFirestore.instance
        .collection('users')
        .doc(UserDM.currentUser!.id)
        .collection('todos');
    todos.get().then((querySnapshot) {
      todosList = querySnapshot.docs.map((documentSnapShot) {
        var json = documentSnapShot.data();
        return TodoDM(
            id: json["id"],
            title: json["title"],
            details: json["details"],
            isDone: json["isDone"],
            time: DateTime.fromMillisecondsSinceEpoch(json["dateTime"]));
      }).toList();
      todosList = todosList.where((todo) {
        if (todo.time.year == selectedDate.year &&
            todo.time.month == selectedDate.month &&
            todo.time.day == selectedDate.day) {
          return true;
        } else {
          return false;
        }
      }).toList();
      notifyListeners();
    });
  }

  deleteTodosFromFirestore(String todoId) {
    var todosCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(UserDM.currentUser!.id)
        .collection('todos');
    var doc = todosCollection.doc(todoId);
    doc.delete().timeout(Duration(milliseconds: 500), onTimeout: () {
      notifyListeners();
    });
  }

}
