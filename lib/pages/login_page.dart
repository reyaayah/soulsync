import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulsync/models/login_models.dart';
import 'package:soulsync/pages/home_page.dart';
import 'package:soulsync/providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF867E9C),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black)),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter E-mail",
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter Password",
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                ref
                    .read(loginProvider(
                            LoginRequest(email: email, password: password))
                        .future)
                    .then((msg) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B3C86),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text("Log In",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("OR"),
                ),
                Expanded(child: Divider()),
              ]),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Google login
              },
              icon: const Icon(Icons.g_mobiledata_rounded, color: Colors.white),
              label: const Text("Login with Google",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 195, 195, 195),
                  )),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B3C86),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Facebook login
              },
              icon: const Icon(Icons.facebook, color: Colors.white),
              label: const Text("Login with Facebook",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 195, 195, 195),
                  )),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B3C86),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text("FORGOT PASSWORD ?",
                  style: TextStyle(
                    color: Color(0xFF4B3C86),
                  )),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Don’t have an account?  Sign Up",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
