import 'package:crudium/database/database_helper.dart';
import 'package:crudium/database/model/user.dart';

abstract class HomeContract {
  void screenUpdate();
}

class HomePresenter {
  HomeContract _view;
  var db = new DatabaseHelper();

  HomePresenter(this._view);

  delete(User user) {
    var db = new DatabaseHelper();
    db.deleteUser(user);
    updateScreen();
  }

  Future<List<User>> getUser() {
    return getUser();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}
