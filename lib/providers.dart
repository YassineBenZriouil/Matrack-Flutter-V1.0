import 'package:flutter/material.dart';

// AuthProvider: manages login state, user role, and username
class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _role = 'Agent';
  String _username = '';
  String? _error;

  bool get isLoggedIn => _isLoggedIn;
  String get role => _role;
  String get username => _username;
  String? get error => _error;

  void login(String username, String password, String role) {
    // TODO: Replace with real authentication logic
    if (username.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _role = role;
      _username = username;
      _error = null;
      notifyListeners();
    } else {
      _error = 'Invalid credentials';
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    _role = 'Agent';
    _username = '';
    notifyListeners();
  }
}

// ScanProvider: manages scan state, OCR result, manual input, and errors
class ScanProvider extends ChangeNotifier {
  bool _isScanning = false;
  String? _ocrResult;
  String? _manualInput;
  String? _scanError;

  bool get isScanning => _isScanning;
  String? get ocrResult => _ocrResult;
  String? get manualInput => _manualInput;
  String? get scanError => _scanError;

  void startScan() {
    _isScanning = true;
    _ocrResult = null;
    _scanError = null;
    notifyListeners();
  }

  void setOcrResult(String result) {
    _ocrResult = result;
    _isScanning = false;
    notifyListeners();
  }

  void setManualInput(String input) {
    _manualInput = input;
    notifyListeners();
  }

  void setScanError(String error) {
    _scanError = error;
    _isScanning = false;
    notifyListeners();
  }

  void reset() {
    _isScanning = false;
    _ocrResult = null;
    _manualInput = null;
    _scanError = null;
    notifyListeners();
  }
}

// HistoryProvider: manages the list of scanned plates
class HistoryProvider extends ChangeNotifier {
  final List<Map<String, String>> _historyList = [];

  List<Map<String, String>> get historyList => List.unmodifiable(_historyList);

  void addHistory(String plate, String date) {
    _historyList.insert(0, {'plate': plate, 'date': date});
    notifyListeners();
  }

  void clearHistory() {
    _historyList.clear();
    notifyListeners();
  }
} 