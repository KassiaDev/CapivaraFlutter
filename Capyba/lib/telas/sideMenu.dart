import 'package:flutter/material.dart';
import 'package:capyba/telas/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capyba/model/ModeloUser.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 154, 217, 163),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader( 
              accountName: Text("Nome"),
              accountEmail: Text("email@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  //child: Image.,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text('Meu Perfil'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.house_rounded),
              title: Text('Home'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(
                Icons.vpn_key_rounded,
              ),
              title: Text('Área Restrita'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.mark_email_read_rounded),
              title: Text('Confirmação de Email'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_rounded),
              title: Text('Sair'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );

  }
}
