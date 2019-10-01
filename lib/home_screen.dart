import 'dart:io';

import 'package:crudium/list.dart';
import 'package:flutter/material.dart';

import 'add_user_dialog.dart';
import 'database/model/user.dart';
import 'home_presenter.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements HomeContract {
  HomePresenter homePresenter;

  @override
  void initState() {
    super.initState();
    homePresenter = new HomePresenter(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _builTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text(
              "User Database",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Future _openAddUserDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            new AddUserDialog().buildAboutDialog(context, this, false, null));
    setState(() {});
  }

  List<Widget> _buildActions() {
    return <Widget>[
      new IconButton(
        icon: const Icon(
          Icons.group_add,
          color: Colors.white,
        ),
        onPressed: () {
          return _openAddUserDialog;
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _builTitle(context),
          actions: _buildActions(),
        ),
        body: FutureBuilder<List<User>>(
          future: homePresenter.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            var data = snapshot.data;
            return snapshot.hasData
                ? new UserList(data, homePresenter)
                : new Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepOrange,
                    ),
                  );
          },
        ));
  }

  @override
  void screenUpdate() {
    // TODO: implement screenUpdate
  }
}
