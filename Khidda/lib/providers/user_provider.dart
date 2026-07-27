import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  void setUser(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    if (_userProfile != null) {
      _userProfile = UserProfile(
        uid: _userProfile!.uid,
        email: _userProfile!.email,
        name: _userProfile!.name,
        phoneNumber: _userProfile!.phoneNumber,
        address: newAddress,
      );
      notifyListeners();
    }
  }

  void clearUser() {
    _userProfile = null;
    notifyListeners();
  }
}
