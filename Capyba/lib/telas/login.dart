import 'package:capyba/telas/cadastro.dart';
import 'package:capyba/telas/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capyba/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Por favor insira seu email");
        }
        if (RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Por favor insira um email válido");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail_outline_rounded),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Insira sua senha para realizar o Login");
        }
        if (!regex.hasMatch(value)) {
          return ("Insira uma senha valida, por favor!");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Senha",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 154, 217, 163),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 250,
                          child: Image.asset(
                            "assets/capybara.png",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 30),
                      emailField,
                      SizedBox(height: 30),
                      passwordField,
                      SizedBox(height: 15),
                      loginButton,
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Não possui cadastro? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaCadastro()));
                            },
                            child: Text(
                              "Cadastre-se",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color.fromARGB(255, 154, 217, 163),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login realizado com Sucesso!"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => TelaHome())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "email-invalido":
            errorMessage = "Seu email parece estar inválido";

            break;
          case "senha-incorreta":
            errorMessage = "Senha incorreta.";
            break;
          case "usuario-nao-encontrado":
            errorMessage = "Não existe usuário cadastrado nesse email";
            break;
          case "usuario-desabilitado":
            errorMessage = "O usuário cadastrado nesse email está desabilitado";
            break;
          case "muitas-requisicoes":
            errorMessage = "Você fez muitas requisições";
            break;
          case "operacacao-empedida":
            errorMessage = "No momento o sistema de Login está em manutenção";
            break;
          default:
            errorMessage = "Um erro não esperado ocorreu";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
