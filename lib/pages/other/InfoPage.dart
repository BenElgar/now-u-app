import 'package:app/assets/components/header.dart';
import 'package:flutter/material.dart';

class InfoPageArgumnets {
  final String title;
  final String body;

  InfoPageArgumnets({
    @required this.title, 
    @required this.body
  });

  String getTitle() {
    return title;
  }  
  String getBody() {
    return body;
  }  
}

class InfoPage extends StatelessWidget {
  
  final InfoPageArgumnets args;

  InfoPage(
    this.args
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PageHeader(
            title: args.getTitle(),
            backButton: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              args.getBody(), 
              style: Theme.of(context).primaryTextTheme.bodyText1,
            )
          ),
        ],
      ),
    );
  }
}
