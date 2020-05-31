import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/models/test_group.dart';
import 'package:multitables/screens/test_screen.dart';
import 'package:multitables/widgets/linear_percent_indicator.dart';

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
    _box = Hive.box(HIVE_PROGRESS_BOX);
    super.initState();
  }

  void selectCategory(BuildContext ctx, TestGroup group) {
    Navigator.of(ctx).pushNamed(TestScreen.routeName, arguments: group);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        margin:
            EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 8.0),
        height: 115.0,
        child: InkWell(
          onTap: () => selectCategory(context, widget.testGroup),
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: double.infinity,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 15.0, bottom: 10.0, right: 10.0),
                      child: Image(
                        image: AssetImage(
                          'assets/images/' + widget.testGroup.iconImage,
                        ),
                        width: 67.0,
                        height: 67.0,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.testGroup.title,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: hexToColor('#3D3D74'),
                              fontSize: 17.0,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              widget.testGroup.itemsCount.toString() +
                                  ' questions',
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15.0, bottom: 5.0),
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box(HIVE_PROGRESS_BOX)
                            .listenable(keys: [widget.testGroup.id]),
                        builder: (context, box, w) {
                          double percent =
                              _box.get(widget.testGroup.id, defaultValue: 0.0);
                          Widget c;
                          if (percent > 0.99) {
                            c = CircleAvatar(
                              radius: 24.0,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 36.0,
                              ),
                              backgroundColor: hexToColor('#4CAF50'),
                            );
                          } else if (percent > 0) {
                            c = CircleAvatar(
                              radius: 24.0,
                              child: Icon(
                                Icons.priority_high,
                                color: Colors.white,
                                size: 36.0,
                              ),
                              backgroundColor: hexToColor('#F7AC1A'),
                            );
                          } else {
                            c = Container();
                          }

                          return c;
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: Hive.box(HIVE_PROGRESS_BOX)
                              .listenable(keys: [widget.testGroup.id]),
                          builder: (context, box, w) {
                            return new LinearPercentIndicator(
                              animation: true,
                              animationDuration: 700,
                              lineHeight: 12.0,
                              percent: _box.get(widget.testGroup.id,
                                  defaultValue: 0.0),
                              backgroundColor: const Color(0xFFE6E6E6),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: const Color(0xFFF7AC1A),
                            );
                          },
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: Hive.box(HIVE_PROGRESS_BOX)
                            .listenable(keys: [widget.testGroup.id]),
                        builder: (context, box, w) {
                          double percent =
                              _box.get(widget.testGroup.id, defaultValue: 0.0);
                          Color c = Colors.grey;
                          if (percent > 0.99) {
                            c = const Color(0xFF4CAF50);
                          } else if (percent > 0) {
                            c = const Color(0xFFF7AC1A);
                          }
                          return Text(
                            (percent * 100).round().toString() + ' %',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: c,
                              fontSize: 16.0,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
