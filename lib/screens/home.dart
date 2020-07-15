import 'package:app/screens/map.dart';
import 'package:app/widgets/animatedbottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
Color mainColor = Color(0xff024b30);
class Home extends StatefulWidget {
  
  final List<BarItem> barItems = [
    BarItem(
      text: 'Ustawienia',
      iconData: Icons.settings,
      color: Colors.white,
    ),
    BarItem(
      text: 'Start',
      iconData: Icons.home,
      color: Colors.white,
    ),
    BarItem(
      text: 'Profil',
      iconData: Icons.person_outline,
      color: Colors.white,
    ),
  ];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _tabController;
  int selectedBarIndex = 1;
  static int points = 155;
  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: selectedBarIndex, length: 3,);
    //_tabController.addListener(_handleTabSelection);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: mainColor, // navigation bar color
    ));
    super.initState();
  }
  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }
  List<Widget> _pages(BuildContext context) => [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.settings, size: 64.0, color: Colors.white),
      ],
    ),
    Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.attach_money, color: Colors.green,),
                      SizedBox(width: 5,),
                      Text(points.toString(), style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.wb_sunny, color: Colors.orange,),
                      SizedBox(width: 5,),
                      Text("30°C".toUpperCase(), style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
        ),
        Material(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
          child: InkWell(
            child: Container(
              //color: Colors.white,
              width: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Jedź".toUpperCase(), style: TextStyle(fontSize: 20),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            splashColor: Colors.black.withOpacity(0.15),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MapPage()
    ));
            },
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 200,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text("Wymień Punkty".toUpperCase(), style: TextStyle(fontSize: 20),),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
        ),//Icon(Icons.home, size: 64.0, color: Colors.white)
      ],
    ),
    Center(child: Icon(Icons.person_outline, size: 64.0, color: Colors.white),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _pages(context)
      )),
      //_pages[selectedBarIndex],
      bottomNavigationBar: AnimatedBottomBar(
        barItems: widget.barItems,
        animationDuration: const Duration(milliseconds: 150),
        barStyle: BarStyle(
        ),
        onBarTap: (int index){
          setState(() {
            selectedBarIndex = index;
            _tabController.animateTo(selectedBarIndex);
            //final TabController controller = DefaultTabController.of(context);
            //if (!controller.indexIsChanging){
              //controller.animateTo(_pages.length-1);
              //selectedBarIndex = _pages.length-1;
            //}
          });
        }
      ),
    );
  }
  /*_handleTabSelection() {
    setState(() {
      print(_tabController.index);
      AnimatedBottomBar().updateBar(_tabController.index);
      selectedBarIndex = _tabController.index;
    });
  }*/
}