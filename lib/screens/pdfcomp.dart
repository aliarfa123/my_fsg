import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_fsg/screens/todo/todoDetail.dart';
import 'package:my_fsg/theme/colors.dart';

pdfComponent(var title) {
  Column(
    children: [
      Expanded(
        child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref('To Do')
              .child(
                title.toString(),
              )
              .orderByKey()
              .onValue
              .asBroadcastStream(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            final tilesList = <Widget>[];
            if (snapshot.hasData) {
              final address =
                  Map<String, dynamic>.from((snapshot.data!).snapshot.value);
              address.forEach((key, value) {
                final nextAdress = Map<String, dynamic>.from(value);
                final adressTile = Padding(
                  padding: EdgeInsets.all(9),
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              )
                            ]),
                        height: MediaQuery.of(context).size.height * 0.11,
                        child: Center(
                          child: ListTile(
                            title: Text(
                              nextAdress['Title'].toString(),
                            ),
                          ),
                        ),
                      )),
                );
                tilesList.add(adressTile);
              });
            }
            return ListView(
              children: tilesList,
            );
          },
        ),
      ),
    ],
  );
}
