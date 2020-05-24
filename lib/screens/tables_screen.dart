import 'package:flutter/material.dart';
import '../funcs/funcs.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/list_item.dart';
import '../widgets/header.dart';

class TablesScreen extends StatelessWidget {
  static const routeName = '/tables';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: hexToColor('#3D3D74')),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Tables',
          style: TextStyle(color: hexToColor('#3D3D74')),
        ),
      ),
      body: TablesBody(),
    );
  }
}

class TablesBody extends StatefulWidget {
  @override
  _TablesBodyState createState() => _TablesBodyState();
}

class _TablesBodyState extends State<TablesBody> {
  int _selectedNumber = 1;

  void _handelTap(int n) {
    setState(() {
      _selectedNumber = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: hexToColor('#F6F7FC'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  left: 20.0, top: 0.0, right: 20.0, bottom: 20.0),
              height: 115.0,
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
                child: TableText(_selectedNumber),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NumberIcon(1, _handelTap, 1 == _selectedNumber),
                    NumberIcon(2, _handelTap, 2 == _selectedNumber),
                    NumberIcon(3, _handelTap, 3 == _selectedNumber),
                    NumberIcon(4, _handelTap, 4 == _selectedNumber),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NumberIcon(5, _handelTap, 5 == _selectedNumber),
                    NumberIcon(6, _handelTap, 6 == _selectedNumber),
                    NumberIcon(7, _handelTap, 7 == _selectedNumber),
                    NumberIcon(8, _handelTap, 8 == _selectedNumber),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NumberIcon(9, _handelTap, 9 == _selectedNumber),
                    NumberIcon(10, _handelTap, 10 == _selectedNumber),
                    NumberIcon(11, _handelTap, 11 == _selectedNumber),
                    NumberIcon(12, _handelTap, 12 == _selectedNumber),
                  ],
                ),
              ],
            ),
            height: 240.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: hexToColor('#CCCED3'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: hexToColor("#999999").withOpacity(0.18),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, -3), // changes position of shadow
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TableText extends StatelessWidget {
  final int _selectedNumber;

  static const odds = [1, 3, 5, 7, 9, 11];
  static const evens = [2, 4, 6, 8, 10, 12];

  TableText(this._selectedNumber);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...odds
                          .map((i) => new Text(
                                '$_selectedNumber x $i',
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: hexToColor('#3D3D74'),
                                    fontSize: 27.0,
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      ...odds
                          .map((i) => new Text(
                                ' = ' + (_selectedNumber * i).toString(),
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: hexToColor('#3D3D74'),
                                    fontSize: 27.0,
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...evens
                      .map((i) => new Text(
                            '$_selectedNumber x $i = ' +
                                (_selectedNumber * i).toString(),
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: hexToColor('#3D3D74'),
                                fontSize: 27.0,
                              ),
                            ),
                          ))
                      .toList(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class NumberIcon extends StatelessWidget {
  final int number;
  final Function tapHandler;
  final bool selected;

  NumberIcon(this.number, this.tapHandler, this.selected);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => tapHandler(number),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Center(
            child: Text(
              number.toString(),
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: (this.selected ? Colors.white : hexToColor('#4785EB')),
                  fontSize: 21.0,
                ),
              ),
            ),
          ),
        ),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: (this.selected ? hexToColor('#3D3D74') : Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(7)),
          boxShadow: [
            BoxShadow(
              color: hexToColor("#999999").withOpacity(0.18),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
