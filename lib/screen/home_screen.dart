import 'package:flutter/material.dart';
import 'package:scrollable/layout/main_layout.dart';
import 'package:scrollable/screen/custom_scroll_view_screen.dart';
import 'package:scrollable/screen/grid_view_screen.dart';
import 'package:scrollable/screen/list_view_screen.dart';
import 'package:scrollable/screen/refresh_indicator.dart';
import 'package:scrollable/screen/reorderable_list_view.dart';
import 'package:scrollable/screen/scrollbar_screen.dart';
import 'package:scrollable/screen/single_child_scroll_view_screen.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String name;

  ScreenModel({
    required this.builder,
    required this.name,
  });
}

class HomeScreen extends StatelessWidget {
  final screens = [
    ScreenModel(
      builder: (_) => SingleChildScrollViewScreen(),
      name: 'singlechildscrollviewscreen',
    ),
    ScreenModel(
      builder: (_) => ListViewScreen(),
      name: 'listviewScreen',
    ),
    ScreenModel(
      builder: (_) => GridViewScreen(),
      name: 'gridViewScreen',
    ),
    ScreenModel(
      builder: (_) => const RedorderableListViewScreen(),
      name: 'reorderableListViewScreen',
    ),
    ScreenModel(
      builder: (_) => CustomScrollViewScreen(),
      name: 'CustomScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => ScrollbarScreen(),
      name: 'ScrollbarScreen',
    ),
    ScreenModel(
      builder: (_) => RefreshIndicatorScreen(),
      name: 'RefreshIndicatorScreen',
    ),
  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: screens
              .map((screen) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: screen.builder),
                    );
                  },
                  child: Text(screen.name)))
              .toList()),
    );
  }
}
