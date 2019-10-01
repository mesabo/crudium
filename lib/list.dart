import 'package:crudium/database/model/user.dart';
import 'package:crudium/home_presenter.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  List<User> country;
  HomePresenter homePresenter;

  UserList(List<User> this.country, HomePresenter this.homePresenter, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: country == null ? 0 : country.length, itemBuilder:,);
  }
}
