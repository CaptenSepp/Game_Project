import 'package:flutter/material.dart';

class MyLeaderboardListView extends StatelessWidget {
  const MyLeaderboardListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            // border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 15, 0), //* 30 right side text
                // todo, the name text must have a limit and stop where it doesn't fit anymore
                child: Text(
                  '${index + 1}' ". Pla...",
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
