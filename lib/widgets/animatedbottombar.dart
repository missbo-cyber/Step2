import 'package:flutter/material.dart';
Color mainColor = Color(0xff024b30);
int selectedBarIndex = 1;
class AnimatedBottomBar extends StatefulWidget {
  
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;
  final Function updateBar;
  final BarStyle barStyle;
  AnimatedBottomBar({this.barItems, this.animationDuration = const Duration(milliseconds: 500), this.onBarTap, this.barStyle, this.updateBar});
  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> with TickerProviderStateMixin{
  //int selectedBarIndex = 1;
  void updateBar(int index){
    setState(() {
      selectedBarIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: mainColor,
      elevation: 10.0,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0, top: 8.0, left: 16.0, right: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBarItems(),
        ),
      ),
    );
  }
  List<Widget> _buildBarItems(){
    List<Widget> _barItems = List();
    for (int i = 0; i<widget.barItems.length; i++){
      bool isSelected = selectedBarIndex == i;
      BarItem item = widget.barItems[i];
      _barItems.add(
        InkWell(
          onTap: () {
            setState(() {
              selectedBarIndex = i;
              widget.onBarTap(selectedBarIndex);
            });
          },
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? item.color.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            duration: widget.animationDuration,
            child: Row(
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: isSelected ? item.color : Colors.black54,
                  size: widget.barStyle.iconSize,
                ),
                SizedBox(width: 10.0,),
                AnimatedSize(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  vsync: this,
                  child: Text(
                  isSelected ? item.text : '',
                  style: TextStyle(
                    color: item.color,
                    fontWeight: widget.barStyle.fontWeight, 
                    fontSize: widget.barStyle.fontSize,
                  )
                ),
                ),
              ],
            ),
          ),
        )
      );
    }
    return _barItems;
  }
}
class BarStyle {
  final double fontSize, iconSize;
  final FontWeight fontWeight;
  BarStyle({this.fontSize = 18.0, this.iconSize = 32, this.fontWeight = FontWeight.w600});
}
class BarItem {
  String text;
  IconData iconData;
  Color color;
  BarItem({this.text, this.iconData, this.color});
}