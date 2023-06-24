import 'package:flutter/material.dart';
import 'package:h_3d_drawer/widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeDrawer(
      drawer: Material(
        child: Container(
          color: const Color(0xff24283b),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 20,
            padding: const EdgeInsets.only(left: 80, top: 100),
            separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(index.toString()),
              );
            },
          ),
        ),
      ),
      child: Scaffold(
        body: Container(
          color: const Color(0xff414468),
          child: const Center(
            child: Text('Hello World!'),
          ),
        ),
      ),
    );
  }
}
