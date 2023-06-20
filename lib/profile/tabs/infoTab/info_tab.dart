import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({
    super.key,
  });

  @override
    Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
          Navigator.pushNamed(context, "/scan");
        }, 
        child: const Text('go to scan')),
        Chip(
          label: const Text('Aaron Burr'),
        ),
      ],
    );
  }
}