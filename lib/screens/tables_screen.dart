import 'package:flutter/material.dart';
import 'package:multitables/funcs/localisations.dart';

class TablesScreen extends StatelessWidget {
  static const routeName = '/tables';

  @override
  Widget build(BuildContext context) {
    return TablesBody();
  }
}

class TablesBody extends StatefulWidget {
  @override
  _TablesBodyState createState() => _TablesBodyState();
}

class _TablesBodyState extends State<TablesBody> {
  bool _chartSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff3D3D74)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('table-screen_table'),
              style: TextStyle(
                color: _chartSelected ? Colors.grey : Color(0xff3D3D74),
              ),
            ),
            Switch(
              value: _chartSelected,
              activeColor: Color(0xff4785EB),
              inactiveThumbColor: Color(0xff4785EB),
              inactiveTrackColor: Color(0x884785EB),
              onChanged: (bool newValue) {
                setState(() {
                  _chartSelected = newValue;
                });
              },
            ),
            Text(
              AppLocalizations.of(context).translate('table-screen_chart'),
              style: TextStyle(
                color: _chartSelected ? Color(0xff3D3D74) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: _chartSelected ? ChartBody() : TableBody(),
    );
  }
}

class ChartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      height: width > height ? height : width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          NumbersColumn(i: 1, firstColumn: true),
          NumbersColumn(i: 1, firstColumn: false),
          NumbersColumn(i: 2, firstColumn: false),
          NumbersColumn(i: 3, firstColumn: false),
          NumbersColumn(i: 4, firstColumn: false),
          NumbersColumn(i: 5, firstColumn: false),
          NumbersColumn(i: 6, firstColumn: false),
          NumbersColumn(i: 7, firstColumn: false),
          NumbersColumn(i: 8, firstColumn: false),
          NumbersColumn(i: 9, firstColumn: false),
          NumbersColumn(i: 10, firstColumn: false),
        ],
      ),
    );
  }
}

class NumbersColumn extends StatelessWidget {
  final int i;
  final bool firstColumn;
  static List<int> intArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  NumbersColumn({
    this.i,
    this.firstColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    right: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    top: BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  color: Color(0xffE3F0FF),
                ),
                child: Center(
                  child: Text(
                    (i).toString(),
                    style: TextStyle(
                      color: Color(0xff3D3D74),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            ...intArr
                .map(
                  (n) => Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        color: () {
                          if (firstColumn) {
                            return Color(0xffE3F0FF);
                          }
                          if (n == i) {
                            return Color(0xffD5F4D6);
                          }
                          return Colors.white;
                        }(),
                      ),
                      child: Center(
                        child: Text(
                          (i * n).toString(),
                          style: TextStyle(
                            color: Color(0xff3D3D74),
                            fontWeight: firstColumn ? FontWeight.w800 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class TableBody extends StatefulWidget {
  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  int _selectedNumber = 1;

  void _handelTap(int n) {
    setState(() {
      _selectedNumber = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 5.0),
              child: Container(
                child: TableText(_selectedNumber),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffE3F0FF), //Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffc3c3c3).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NumberIcon(1, _handelTap, 1 == _selectedNumber),
                    NumberIcon(2, _handelTap, 2 == _selectedNumber),
                    NumberIcon(3, _handelTap, 3 == _selectedNumber),
                    NumberIcon(4, _handelTap, 4 == _selectedNumber),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NumberIcon(5, _handelTap, 5 == _selectedNumber),
                    NumberIcon(6, _handelTap, 6 == _selectedNumber),
                    NumberIcon(7, _handelTap, 7 == _selectedNumber),
                    NumberIcon(8, _handelTap, 8 == _selectedNumber),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NumberIcon(9, _handelTap, 9 == _selectedNumber),
                    NumberIcon(10, _handelTap, 10 == _selectedNumber),
                    NumberIcon(11, _handelTap, 11 == _selectedNumber),
                    NumberIcon(12, _handelTap, 12 == _selectedNumber),
                  ],
                ),
              ],
            ),
            height: 250.0,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...odds
                      .map((i) => new Text(
                            '$_selectedNumber \u00D7 $i = ' + (_selectedNumber * i).toString(),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff3D3D74),
                              fontSize: 24.0,
                            ),
                          ))
                      .toList(),
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
                            '$_selectedNumber \u00D7 $i = ' + (_selectedNumber * i).toString(),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff3D3D74),
                              fontSize: 24.0,
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
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.all(0),
      onPressed: () => tapHandler(number),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: (this.selected ? Colors.white : Color(0xff3C8DEF)),
                fontSize: 30.0,
              ),
            ),
          ),
        ),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: (this.selected ? const Color(0xff3C8DEF) : Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff999999).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
