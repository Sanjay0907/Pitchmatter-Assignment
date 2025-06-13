import 'package:flutter/material.dart';
import 'package:pitchmatter_assignment/model/user_model.dart';
import 'package:pitchmatter_assignment/services/user_services.dart';

class UserProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<UserModel> _allUsers = [];
  List<UserModel> _displayedUsers = [];
  int _currentPage = 0;
  final int _pageSize = 10;
  String _searchTerm = '';

  List<UserModel> get users => _displayedUsers;

  Future<void> loadUsers() async {
    _allUsers = await _apiService.fetchUsers();
    _displayedUsers.clear();
    _currentPage = 0;
    _loadNextPage();
  }

  void _loadNextPage() {
    final filtered = _allUsers
        .where((u) => u.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
    final start = _currentPage * _pageSize;
    final end = start + _pageSize;
    _displayedUsers.addAll(filtered.sublist(
        start.clamp(0, filtered.length), end.clamp(0, filtered.length)));
    _currentPage++;
    notifyListeners();
  }

  void loadMore() => _loadNextPage();

  void search(String term) {
    _searchTerm = term;
    _displayedUsers.clear();
    _currentPage = 0;
    _loadNextPage();
  }

  UserModel? getUserById(int id) => _allUsers.firstWhere(
        (u) => u.id == id,
      );
}
