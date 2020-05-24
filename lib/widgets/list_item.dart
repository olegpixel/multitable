import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/constants.dart';
import 'package:multitables/models/test_group.dart';
import 'package:multitables/screens/test_screen.dart';

class ListItem extends StatefulWidget {
  final TestGroup testGroup;

  const ListItem({
    this.testGroup,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  Box _box;

  @override
  void initState() {
    _box = Hive.box(hiveProgressBox);
    super.initState();
  }

  void selectCategory(BuildContext ctx, TestGroup group) {
    Navigator.of(ctx).pushNamed(TestScreen.routeName, arguments: group);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin:
            EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 8.0),
        height: 115.0,
        child: InkWell(
          onTap: () => selectCategory(context, widget.testGroup),
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: hexToColor("#c3c3c3").withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(0, -2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 67.0,
                        height: 67.0,
                        decoration: BoxDecoration(
                          color: hexToColor('#5F4C9E'),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.testGroup.title,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: hexToColor('#3D3D74'),
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              widget.testGroup.title +
                                  ' progress:' +
                                  (_box.get(widget.testGroup.id,
                                          defaultValue: 0))
                                      .toString(),
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: hexToColor('#999999'),
                                  fontSize: 11.0,
                                ),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: Hive.box(hiveProgressBox)
                                .listenable(keys: [widget.testGroup.id]),
                            builder: (context, box, w) {
                              return Text(
                                (_box.get(widget.testGroup.id, defaultValue: 0))
                                    .toString(),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
