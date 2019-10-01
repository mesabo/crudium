import 'package:crudium/database/database_helper.dart';
import 'package:flutter/material.dart';

import 'database/model/user.dart';

class AddUserDialog {
  final theFirstName = TextEditingController();
  final theLastName = TextEditingController();
  final theDob = TextEditingController();
  User user;

  static const TextStyle linkStyle =
      const TextStyle(color: Colors.blue, decoration: TextDecoration.underline);

  Widget buildAboutDialog(
      BuildContext context, _myHomePageState, bool isEdit, User user) {
    if (user != null) {
      this.user = user;
      theFirstName.text = user.firstName;
      theLastName.text = user.lastName;
      theDob.text = user.dob;
    }

    return new AlertDialog(
      title:
          new Text(isEdit ? 'Editer utilisateur' : 'Ajouter new utilisateur'),
      content: new SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Saisir Nom", theFirstName),
            getTextField("Saisir Prénom", theLastName),
            getTextField("JJ-MM-AAAA", theDob),
            new GestureDetector(
              onTap: () {
                addRecord(isEdit);
                _myHomePageState.displayRecord();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Editer" : "Ajouter",
                    EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(hintText: inputBoxName),
      ),
    );

    return loginBtn;
  }

  getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
          border: Border.all(color: const Color(0xFF28324E)),
          borderRadius: new BorderRadius.all(const Radius.circular(6.0))),
      child: Text(
        buttonLabel,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
            color: const Color(0xFF28324E)),
      ),
    );

    return loginBtn;
  }

  void addRecord(bool isEdit) async {
    var db = new DatabaseHelper();
    var user = new User(theFirstName.text, theLastName.text, theDob.text);

    if (isEdit) {
      user.setUserId(this.user.id);
      await db.updateUser(user);
    } else {
      await db.saveUser(user);
    }
  }
}
