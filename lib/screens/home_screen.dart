import 'package:flutter/material.dart';
import 'package:whatsap_clone/widgets/aba_contacto.dart';
import 'package:whatsap_clone/widgets/aba_conversa.dart';

const HOME_SCREEN = "/home_screen";

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WhatsapClone"),
          bottom: TabBar(
            indicatorWeight: 4,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            controller: _tabController,
            tabs: [
              Tab(text: "Conversas"),
              Tab(text: "Contactos"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            AbaConversa(),
            AbaContacto(),
          ],
        ));
  }
}
