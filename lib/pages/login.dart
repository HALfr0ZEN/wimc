import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wimc/core/res/color.dart';
import 'package:wimc/firebase_options.dart';
import 'package:wimc/pages/home.dart';
import 'package:wimc/widget/navigationDrawer.dart';
import 'package:wimc/widget/scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Future<FirebaseApp> _initFirebase() async {
  //   FirebaseApp firebaseApp = await ;
  //   return firebaseApp;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Firebase.initializeApp(options: DefaultFirebaseOptions.android),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const LoginForm();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  static Future<User?> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential usercre = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = usercre.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.primaryColor,
            content: const Text('No user')));
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Login",
                style:
                    TextStyle(color: AppColors.secondaryColor, fontSize: 40)),
            Text("Whats in my closet",
                style: TextStyle(
                    color: AppColors.primaryHeaderColor, fontSize: 10)),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Email',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This is a required';
                      }
                      RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      bool match = exp.hasMatch(value);
                      if (!match) {
                        return 'Not valid email address';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      labelText: 'Password',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This is a required field';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot password ?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryHeaderColor),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Don't have account ?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.primaryHeaderColor),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login(
                              context: context,
                              email: _email.text,
                              password: _password.text,
                            ).then(
                              (user) {
                                if (user != null) {
                                  navigateTo(const Home(), context);
                                }
                              },
                            );
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
