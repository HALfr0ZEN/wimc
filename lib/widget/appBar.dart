import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wimc/core/res/color.dart';
import 'package:wimc/pages/settings.dart';
import 'package:wimc/widget/navigationDrawer.dart';
import 'package:http/http.dart' as http;

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  var title = "";

  @override
  void initState() {
    setTitleValue();
    super.initState();
  }

  Future<String> getCurrentWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=49.22&longitude=17.66&current_weather=true'));
    final body = jsonDecode(response.body);
    return body["current_weather"]["temperature"].toString() + "°C";
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat("EEEE").format(now);
  }

  Future<void> setTitleValue() async {
    var weather = await getCurrentWeather();
    setState(() {
      title = "${getCurrentDate()} $weather";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: IconButton(
          icon: const Icon(Icons.menu_rounded),
          color: AppColors.primaryColor,
          splashRadius: 20,
          onPressed: () => {Scaffold.of(context).openDrawer()},
        ),
      ),
    );
  }
}
