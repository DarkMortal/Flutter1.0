import 'package:flutter/material.dart';
import 'package:flutter1/Components/Items.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text("Todos Routine"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: Theme.of(context).iconTheme,
                  textTheme: Theme.of(context).textTheme,
                ),
                child: Settings()
            )
          ],
        ),
        body: AddButtons(),
        drawer: Navbar(),
      );
}