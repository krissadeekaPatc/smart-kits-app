import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'notification_detail.dart';

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  SlidableController slidableController = SlidableController();
  String datetimeFormat(String date) {
    var format = DateTime.fromMillisecondsSinceEpoch(
        (int.parse(date) + 25200) * 1000,
        isUtc: true);
    var result = DateFormat('Hm').format(format);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Color(0xff005C4F),
        elevation: 10,
        shadowColor: Colors.blue,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (c, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationsDetailsPage(
                          headers: i.toString(),
                        ),
                      ));
                },
                child: Slidable(
                  controller: slidableController,
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: [
                    Container(
                      height: double.infinity,
                      child: IconSlideAction(
                          color: Color(0xffED2024), icon: Icons.delete_forever),
                    ),
                  ],
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.add_circle_outline),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Notifications Header"),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
