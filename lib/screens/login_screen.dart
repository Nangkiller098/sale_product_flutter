import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:sale_product_flutter/models/request/LoginRequest.dart';
import 'package:sale_product_flutter/models/response/LoginResponse.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenStateState();
}

class _LoginScreenStateState extends State<LoginScreen> {
  final _keyForm = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = LocalStorage('USER_SESSION');
  bool isLoading = false;

  login() async {
    setState(() {
      isLoading = true;
    });
    LoginRequest req = LoginRequest();
    var username = _usernameController.text;
    var password = _passwordController.text;
    req.password = password;
    req.username = username;

    var url = Uri.parse("https://dummyjson.com/auth/login");
    var response = await http.post(url, body: req.toJson());
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
      var user = LoginResponse.fromJson(map);
      // print(user);
      setState(() {
        isLoading = false;
      });
      storage.setItem("USER_NAME", user.username);
      storage.setItem("USER_EMAIL", user.email);
      storage.setItem("USER_TOKEN", user.token);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } else {
      if (kDebugMode) {
        print("Can not Loin");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Login Title",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
            child: TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "UserName"),
              // validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Your UserName";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password"),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              // validation
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Your Password";
                }
                return null;
              },
            ),
          ),
          isLoading == true
              ? Container(
                  decoration: const BoxDecoration(color: Colors.teal),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    if (_keyForm.currentState!.validate()) {
                      login();
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.teal),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                    child: const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
          Container(
              padding: const EdgeInsets.only(top: 10, right: 20),
              width: double.infinity,
              child: Text(
                "Forgot Password?",
                textAlign: TextAlign.end,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ]),
      ),
    );
  }
}
