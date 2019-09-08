import 'package:custodia/widgets/overlay-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../theme-provider.dart';

class ListItem extends StatelessWidget {

  ListItem({this.title, this.description, this.points, this.color});

  final String title;
  final String description;
  final int points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Ignore',
          color: ThemeProvider.blue8,
//          icon: Icons.block,
          iconWidget: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red,

//                border: Border.all(
//                    color: ThemeProvider.orange,
//                    width: 1.5
//                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.block, color: Colors.white, size: 30,)
          ),
          onTap: () => showOverlayDialog(context),
        )
      ],
//      direction: DismissDirection.startToEnd,
//      background: Container(color: Colors.green,),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3)
              ),
              width: 90,
              height: 90,
              child: Text(
                "$points points",
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: ThemeProvider.grey1,
                    ),
//                    Shadow(
//                      offset: Offset(10.0, 10.0),
//                      blurRadius: 8.0,
//                      color: Color.fromARGB(125, 0, 0, 255),
//                    ),
                  ],
                )
              ),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "RobotoMedium"
                    )
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 20,
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showOverlayDialog(BuildContext context) {
//    Navigator.of(context).push(
//        PageRouteBuilder(
//          opaque: false,
//          pageBuilder: (BuildContext context, _, __) => OverlayDialog()
//        )
//    );
//    Navigator.of(context).push(OverlayDialog());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OverlayDialog()),
    );
  }
}
