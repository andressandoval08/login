// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: SignUpScreen(),
    ),
  );
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        print('Token de autenticación: ${data['token']}');
        print('¡Inicio de sesión exitoso!');

        // Navegar a la pantalla de inicio de sesión exitoso
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessfulLoginScreen()),
        );
      } else {
        // Imprimir un mensaje de error
        print(
            'Inicio de sesión fallido. Estado de la respuesta: ${response.statusCode}');
      }
    } catch (e) {
      print('Excepción durante la llamada a la API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TADEO APP',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            // Campo de correo electrónico
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(height: 20),
            // Campo de contraseña
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(height: 40),
            // Botón de inicio de sesión
            GestureDetector(
              onTap: () {
                login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('Iniciar sesión'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessfulLoginScreen extends StatelessWidget {
  const SuccessfulLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión exitoso'),
      ),
      body: Center(
        child: Text(
          '¡Bienvenido, usuario correcto!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
