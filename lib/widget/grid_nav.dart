import 'package:flutter/material.dart';
import 'package:tour/model/common_model.dart';
import 'package:tour/model/grid_nav_model.dart';

class GridNav extends StatelessWidget{
  final GridNavModel gridNav;
  final String name;

  const GridNav({Key key, @required this.gridNav, this.name='xiaoming'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*PhysicalModelは角丸の設定です。影の色とZ軸の高さを設定できます*/
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNav == null) return items;
    if (gridNav.hotel != null) {
      items.add(_gridNavItem(context, gridNav.hotel, true));
    }
    return items;
  }

  Widget _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    List<Widget> expandItems = [];
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor}'));

    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    items.forEach((item) {
      expandItems.add(Expanded(
          child: item,
          flex: 1,
      ));
    });

    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        // 勾配色
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );

  }

  Widget _mainItem(BuildContext context, CommonModel model){
    Widget mainWidget = Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        // TODO
      ],
    );
    return _wrapGesture(context, mainWidget, model);
  }

  Widget _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem){
    // TODO
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model){
    // TODO
  }

//  @override
//  _GridNavState createState() => _GridNavState();

}

/*
class _GridNavState extends State<GridNav>{

  @override
  Widget build(BuildContext context) {
    return Text(widget.name);
  }

}*/
