import 'dart:async';

import "package:flutter/material.dart";

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchQuery = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchQuery.text.replaceAll(" ", "_");
      print(query);
    });
  }

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: TextField(
                autofocus: true,
                cursorColor: Theme.of(context).textTheme.bodyText1.color,
                decoration: InputDecoration.collapsed(
                    hintText: 'Digite uma palavra chave'),
                controller: _searchQuery)),
        body: Text("hm"));
  }
}
