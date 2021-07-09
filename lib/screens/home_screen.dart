import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsap_clone/screens/login_screen.dart';
import 'package:whatsap_clone/widgets/aba_contacto.dart';
import 'package:whatsap_clone/widgets/aba_conversa.dart';

import 'configuracoes_screen.dart';

const HOME_SCREEN = "/home_screen";

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<String> itensMenu = [
    "Configuracoes",
    "Sair",
  ];

  Future _verificaUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser usuarioLoagado = await auth.currentUser();

    if (usuarioLoagado == null) {
      Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
    }
  }

  @override
  void initState() {
    super.initState();
    _verificaUsuarioLogado();

    _tabController = TabController(length: 2, vsync: this);
  }

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configuracoes":
        Navigator.pushNamed(context, CONFIGURACOES_SCREEN);
        break;
      case "Sair":
        _sair();
        break;
    }
  }

  void _sair() async {
    print("Sair");
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();

    Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsapClone"),
        elevation: Platform.isIOS ? 0 : 4,
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: Platform.isIOS ? Colors.grey[400] : Colors.white,
          controller: _tabController,
          tabs: [
            Tab(text: "Conversas"),
            Tab(text: "Contactos"),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (_) => itensMenu
                .map((item) => PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onSelected: _escolhaMenuItem,
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AbaConversa(),
          AbaContacto(),
        ],
      ),
    );
  }
}
