import 'package:flutter/material.dart';
import 'package:wimc/core/res/color.dart';
import 'package:wimc/pages/clothes/add.dart';
import 'package:wimc/pages/clothes/index.dart';
import 'package:wimc/pages/home.dart';
import 'package:wimc/pages/settings.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

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
              imageUrl: "a",
              name: "name",
              context: context,
            ),
            ...buildMenu(context: context),
            const Spacer(),
            const Divider(color: Colors.white, height: 10),
            createMenuChild(
              icon: Icons.settings,
              label: "Settings",
              onClicked: () => navigateTo(const Settings(), context),
              context: context,
            ),
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

Widget createHeader(
    {required String imageUrl,
    required String name,
    required BuildContext context}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
    color: Color.fromARGB(50, 0, 0, 0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
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
