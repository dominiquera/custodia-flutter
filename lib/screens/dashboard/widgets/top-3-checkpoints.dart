import 'package:custodia/main.dart';
import 'package:custodia/models/maintenance_item.dart';
import 'package:custodia/screens/dashboard/widgets/slidable-3-item-card.dart';
import 'package:custodia/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../theme-provider.dart';
import '../../learn-more-about.dart';
import 'overlay-request.dart';
import 'overlay-ignore.dart';
import 'package:custodia/screens/dashboard/widgets/overlay-done.dart';

class Top3Checkpoints extends StatefulWidget {

  final List<MaintenanceItem>  items;
  final Function onUpdate;

  Top3Checkpoints({this.items,this.onUpdate});

  @override
  _Top3CheckpointsState createState() => _Top3CheckpointsState();
}

class _Top3CheckpointsState extends State<Top3Checkpoints> {


  @override
  void initState() {
    widget.items.asMap().forEach((index, item) {
      children.add(
          Slidable3ItemCard(item: item,key: Key("index_${item.id}"),index: index + 1 ,onActionDone: hideItem,)
      );
      children.add(SizedBox(height: 30));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemeProvider.screenPadding),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: ThemeProvider.grey2,
            offset: const Offset(0.0, 0.0),
          ),
          const BoxShadow(
            color: ThemeProvider.lightBlue,
            offset: const Offset(0.0, 0.0),
            spreadRadius: -1.0,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "TOP THREE TODAY",
            style: TextStyle(
              fontFamily: "NunitoBlack",
              color: ThemeProvider.orange,
              fontSize: 24,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 1.0,
                  color: ThemeProvider.lightGrey1,
                ),
              ]
            )
          ),
          SizedBox(height: 5),
          Text(
            "These are the suggested top three checkpoints",
            style: TextStyle(
              fontFamily: "NunitoMedium",
              color: ThemeProvider.grey2
            )
          ),
          SizedBox(height: 30),
          top3Items()
        ],
      ),
    );
  }



  List<Widget> children = [];
  hideItem(int itemId) {
    setState(() {
      children.removeWhere((item) => item.key == Key("index_$itemId"));
    });
    widget.onUpdate();
  }

  top3Items(){
    return Column(
        children: children
    );
  }

//  openLearnMoreScreen(MaintenanceItem maintenanceItem) {
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => LearnMoreAboutPage(item: maintenanceItem)),
//    );
//  }
//
//  void showAutomateOverlayDialog(MaintenanceItem maintenanceItem) {
//    Navigator.of(context).push(
//        PageRouteBuilder(
//            opaque: false,
//            pageBuilder: (BuildContext context, _, __) => OverlayAutomate(item: maintenanceItem, onAutomate: hideItem(maintenanceItem.id))
//        )
//    );
//  }
//
//
//  showIgnoreOverlayDialog(MaintenanceItem maintenanceItem) {
//    Navigator.of(context).push(
//        PageRouteBuilder(
//            opaque: false,
//            pageBuilder: (BuildContext context, _, __) => OverlayIgnore(item: maintenanceItem, onIgnore: hideItem(maintenanceItem.id))
//        )
//    );
//  }
//
//  showOverlayDialog(MaintenanceItem maintenanceItem) {
//    Navigator.of(context).push(
//        PageRouteBuilder(
//            opaque: false,
//            pageBuilder: (BuildContext context, _, __) => DoneOverlayDialog(item: maintenanceItem,)
//        )
//    );
//  }
//
//  markAsDone(MaintenanceItem maintenanceItem){
//    APIService.markDoneMaintenanceItem(maintenanceItem.id, onMarkDoneSuccess, onMarkDoneFailure);
//  }
//
//  void onMarkDoneSuccess(String body,MaintenanceItem maintenanceItem){
//    hideItem(maintenanceItem.id);
//    Navigator.of(context).push(
//        PageRouteBuilder(
//            opaque: false,
//            pageBuilder: (BuildContext context, _, __) => DoneOverlayDialog(item: maintenanceItem)
//        )
//    );
//  }
//
//  void onMarkDoneFailure() {
//    print(">>>onMarkDoneFailure");
//  }
//
//
//  List<Widget> mainActions(MaintenanceItem maintenanceItem) {
//    return <Widget>[
//      IconSlideAction(
//        caption: 'Close',
//        color: ThemeProvider.blue8,
//        iconWidget: Container(
//            width: 60,
//            height: 60,
//
//            decoration: BoxDecoration(
//              color: Colors.red,
//              shape: BoxShape.circle,
//            ),
//            child: Icon(Icons.block, color: Colors.white, size: 30,)
//        ),
//        onTap: () => showIgnoreOverlayDialog(maintenanceItem),
//      )
//    ];
//  }

//  List<Widget> headerCardSlideActions(MaintenanceItem maintenanceItem) {
//    return <Widget>[
//      IconSlideAction(
//        caption: 'Done',
//        color: ThemeProvider.blue8,
//        iconWidget: Container(
//            width: 60,
//            height: 60,
//            decoration: BoxDecoration(
//              color: ThemeProvider.green3,
//              shape: BoxShape.circle,
//
//            ),
//            child: Icon(Icons.check, color: Colors.white, size: 35,)
//        ),
//        onTap: () => markAsDone(maintenanceItem),
//      ),
//      IconSlideAction(
//        caption: 'Request',
//        color: ThemeProvider.blue8,
//        iconWidget: Container(
//            width: 60,
//            height: 60,
//            decoration: BoxDecoration(
//              color: ThemeProvider.blue7,
//              shape: BoxShape.circle,
//            ),
//            child: Icon(Icons.room_service, color: Colors.white, size: 30,)
//        ),
//        onTap: () => showAutomateOverlayDialog(maintenanceItem),
//      ),
//      IconSlideAction(
//        caption: 'Learn',
//        color: ThemeProvider.blue8,
//        iconWidget: Container(
//            width: 60,
//            height: 60,
//            decoration: BoxDecoration(
//              color: ThemeProvider.lightBrown,
//              shape: BoxShape.circle,
//            ),
//            child: Icon(Icons.school, color: Colors.white, size: 30,)
//        ),
//        onTap: () => openLearnMoreScreen(maintenanceItem),
//      )
//    ];
//  }




//  Widget top3Item(int index, MaintenanceItem maintenanceItem) {
//    return Slidable(
//      key: widget.key,
//      actionPane: SlidableScrollActionPane(),
//      actions: mainActions(maintenanceItem),
//      secondaryActions: headerCardSlideActions(maintenanceItem),
//      child: InkWell(
//        onTap: () => openLearnMoreScreen(maintenanceItem),
//        child: Container(
//          margin: EdgeInsets.only(bottom: 30),
//          child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Column(
//                    children: <Widget>[
//                      Container(
//                        width: 45,
//                        height: 45,
//                        decoration: BoxDecoration(
//                          border: Border.all(
//                              color: ThemeProvider.orange,
//                              width: 1.5
//                          ),
//                          shape: BoxShape.circle,
//                        ),
//                        child: Center(
//                            child: Text(
//                                index.toString(),
//                                style: TextStyle(
//                                    fontFamily: "NunitoMedium",
//                                    color: ThemeProvider.orange,
//                                    fontSize: 22
//                                )
//                            )
//                        ),
//                      ),
//                      SizedBox(height: 5),
//                      Text(
//                          "${maintenanceItem.points} POINTS",
//                          style: TextStyle(
//                              color: ThemeProvider.orange,
//                              fontFamily: "NunitoMedium",
//                              fontSize: 12
//                          )
//                      )
//                    ]
//                ),
//                SizedBox(width: 15),
//                Expanded(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(maintenanceItem.title,
//                          style: TextStyle(
//                              fontSize: 20,
//                              color: ThemeProvider.darkGrey,
//                              fontFamily: "NunitoMedium"
//                          )
//                      ),
//                      SizedBox(height: 5),
//                      Text(maintenanceItem.description,
//                          style: TextStyle(
//                            fontSize: 13,
//                            color: ThemeProvider.darkGrey,
//                          )
//                      ),
//                    ],
//                  ),
//                ),
//              ]
//          ),
//        ),
//      ),
//    );
//  }


}
