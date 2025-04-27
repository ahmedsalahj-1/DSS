import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _userName;
  String? _userEmail;
  
  // Store registered users temporarily
  final Map<String, Map<String, String>> _registeredUsers = {};

  bool get isLoading => _isLoading;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  Future<void> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Check if user is registered
      if (!_registeredUsers.containsKey(email)) {
        throw 'User not found. Please sign up first.';
      }
      
      // Check password
      if (_registeredUsers[email]!['password'] != password) {
        throw 'Invalid password';
      }
      
      // Set current user
      _userEmail = email;
      _userName = _registeredUsers[email]!['fullName'];
      
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password, String fullName) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Check if email already exists
      if (_registeredUsers.containsKey(email)) {
        throw 'Email already registered';
      }
      
      // Register new user
      _registeredUsers[email] = {
        'email': email,
        'password': password,
        'fullName': fullName,
      };
      
      // Set current user
      _userEmail = email;
      _userName = fullName;
      
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _userEmail = null;
    _userName = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    if (!_registeredUsers.containsKey(email)) {
      throw 'User not found';
    }
    // In a real app, you would send a password reset email
    await Future.delayed(const Duration(seconds: 1));
  }
} 