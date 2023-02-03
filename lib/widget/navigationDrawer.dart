import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wimc/core/res/color.dart';
import 'package:wimc/pages/clothes/add.dart';
import 'package:wimc/pages/clothes/index.dart';
import 'package:wimc/pages/home.dart';
import 'package:wimc/pages/login.dart';
import 'package:wimc/pages/settings.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  String getUserName() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      final email = user.email;
      if (email != null) {
        return email.split('@')[0];
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffd61557), Color(0xfff44336)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            createHeader(
              name: getUserName(),
              context: context,
            ),
            ...buildMenu(context: context),
            const Spacer(),
            const Divider(color: Colors.white, height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: AppColors.backgroundColor,
                  onPressed: () => navigateTo(const Settings(), context),
                  icon: const Icon(Icons.settings),
                ),
                IconButton(
                  color: AppColors.backgroundColor,
                  onPressed: () => navigateTo(const LoginForm(), context),
                  icon: const Icon(Icons.logout),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Iterable<Widget> buildMenu({required BuildContext context}) {
  Iterable<Widget> pages = pagesMap.map(
    (page) => createMenuChild(
      icon: page["icon"],
      label: page["label"],
      context: context,
      onClicked: () => navigateTo(page["pagelink"], context),
    ),
  );

  return pages;
}

Widget createMenuChild(
    {required IconData icon,
    required String label,
    VoidCallback? onClicked,
    required BuildContext context}) {
  const color = Colors.white;

  return ListTile(
    onTap: onClicked,
    splashColor: const Color.fromARGB(255, 255, 214, 64),
    leading: Icon(icon, color: AppColors.backgroundColor),
    title: Text(
      label,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.backgroundColor),
    ),
  );
}

List<Map<String, dynamic>> pagesMap = [
  {
    "label": "Home",
    "icon": Icons.home,
    "pagelink": const Home(),
  },
  {
    "label": "Clothes",
    "icon": Icons.checkroom,
    "pagelink": const ShowClothes(),
  },
  {
    "label": "AddClothes",
    "icon": Icons.add_circle,
    "pagelink": const AddClothes(),
  },
];

void navigateTo(Widget page, BuildContext context) {
  Navigator.of((context)).push(MaterialPageRoute(builder: (context) => page));
}

Widget createHeader({required String name, required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
    color: Color.fromARGB(50, 0, 0, 0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          child: Text(name.substring(0, 2)),
        ),
        const SizedBox(width: 20),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.textColor),
        )
      ],
    ),
  );
}
