import 'package:flutter/material.dart';
import 'package:capyba/telas/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capyba/model/ModeloUser.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmePassword = TextEditingController();
  final _auth = FirebaseAuth.instanceFor;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      autofocus: false,
      controller: name,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("O campo nome não pode ficar vazio");
        }
        if (!regex.hasMatch(value)) {
          return ("Insira um nome válido por favor");
        }
        return null;
      },
      onSaved: (value) {
        name.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.perm_identity_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Nome",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastName,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("O campo Sobrenome não pode ficar vazio");
        }
        return null;
      },
      onSaved: (value) {
        lastName.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.perm_identity_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Sobrenome",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: email,
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
        email.text = value!;
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
      controller: password,
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
        password.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Senha",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final confirmePasswordField = TextFormField(
      autofocus: false,
      controller: confirmePassword,
      keyboardType: TextInputType.number,
      obscureText: true,
      validator: (value) {
        if (confirmePassword.text.length > 8 &&
            confirmePassword.text != value) {
          return "As senhas não combinam";
        }
        return null;
      },
      onSaved: (value) {
        confirmePassword.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_rounded),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirme sua Senha",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final singupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 154, 217, 163),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {},
          child: Text(
            "Cadastre-se",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 154, 217, 163),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
                          height: 150,
                          child: Image.asset(
                            "assets/capybara.png",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 20),
                      nameField,
                      SizedBox(height: 20),
                      lastNameField,
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 20),
                      passwordField,
                      SizedBox(height: 20),
                      confirmePasswordField,
                      SizedBox(height: 15),
                      singupButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

/* void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password)
            //.createUserWithEmailAndPassword está sem funcionar pois não consigo acessar o HASH code da máquina que estou
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    ModeloUser userModel = ModeloUser();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = name.text;
    userModel.lastName = lastName.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Conta criada com sucesso");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => TelaHome()), (route) => false);
  } Código sem funcionar devido a problemas na consumação da API do backend*/
}
