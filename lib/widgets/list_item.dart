import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/progress_dao.dart';
import 'package:multitables/models/test_group.dart';
import 'package:multitables/screens/test_screen.dart';
import 'package:multitables/screens/test_exam_screen.dart';
import 'package:multitables/widgets/linear_percent_indicator.dart';
import 'package:multitables/funcs/localisations.dart';

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
    if (group.withVariants) {
      Navigator.of(ctx).pushNamed(TestScreen.routeName, arguments: group);
    } else {
      Navigator.of(ctx).pushNamed(TestExamScreen.routeName, arguments: group);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context);
    final screenWidth = mediaQuerySize.size.width;
    final screenHeight = mediaQuerySize.size.height;
    final hc = screenHeight / 683;
    final wc = screenWidth / 411;

    return Container(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20.0 * wc, top: 10.0 * hc, right: 20.0 * wc, bottom: 8.0 * hc),
        height: 115.0 * hc,
        child: InkWell(
          onTap: () => selectCategory(context, widget.testGroup),
          borderRadius: BorderRadius.circular(8.0 * hc),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0 * hc),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffc3c3c3).withOpacity(0.5),
                  spreadRadius: 4 * wc,
                  blurRadius: 8 * wc,
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
                      padding: EdgeInsets.only(top: 5.0 * hc, left: 15.0 * wc, bottom: 10.0 * hc, right: 10.0 * wc),
                      child: Image(
                        image: AssetImage(
                          'assets/images/' + widget.testGroup.iconImage,
                        ),
                        width: 67.0 * wc,
                        height: 67.0 * hc,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).translate(widget.testGroup.id),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xff3D3D74),
                              fontSize: 17.0 * wc,
                            ),
                          ),
                          Padding(
                            padding: widget.testGroup.withVariants
                                ? EdgeInsets.only(top: 8.0 * hc, bottom: 8.0 * wc)
                                : EdgeInsets.only(top: 4.0 * hc, bottom: 8.0 * wc),
                            child: Text(
                              (widget.testGroup.withVariants
                                      ? ''
                                      : (AppLocalizations.of(context).translate(widget.testGroup.id + '-description') +
                                          '\n')) +
                                  widget.testGroup.itemsCount.toString() +
                                  ' ' +
                                  AppLocalizations.of(context).translate('practice-screen_text-questions'),
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 13.0 * wc,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15.0 * wc, bottom: 5.0 * hc),
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box(HIVE_PROGRESS_BOX).listenable(keys: [widget.testGroup.id]),
                        builder: (context, box, w) {
                          double percent = _box.get(widget.testGroup.id, defaultValue: 0.0);
                          Widget c;
                          if (percent > 0.99) {
                            c = CircleAvatar(
                              radius: 20.0 * hc,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 36.0 * hc,
                              ),
                              backgroundColor: Color(0xff4CAF50),
                            );
                          } else if (percent > 0) {
                            c = CircleAvatar(
                              radius: 20.0 * hc,
                              child: Icon(
                                Icons.priority_high,
                                color: Colors.white,
                                size: 36.0 * hc,
                              ),
                              backgroundColor: Color(0xffF7AC1A),
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
                  margin: EdgeInsets.only(left: 10.0 * wc, right: 10.0 * wc),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: Hive.box(HIVE_PROGRESS_BOX).listenable(keys: [widget.testGroup.id]),
                          builder: (context, box, w) {
                            double percent = _box.get(widget.testGroup.id, defaultValue: 0.0);
                            percent = percent > 1 ? 1 : percent;
                            return new LinearPercentIndicator(
                              animation: true,
                              animationDuration: 700,
                              lineHeight: 12.0 * hc,
                              percent: percent,
                              backgroundColor: const Color(0xFFE6E6E6),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: const Color(0xFFF7AC1A),
                            );
                          },
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: Hive.box(HIVE_PROGRESS_BOX).listenable(keys: [widget.testGroup.id]),
                        builder: (context, box, w) {
                          double percent = _box.get(widget.testGroup.id, defaultValue: 0.0);
                          percent = percent > 1 ? 1 : percent;
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
                              fontSize: 14.0 * wc,
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
