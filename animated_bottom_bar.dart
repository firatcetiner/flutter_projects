import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedBottomnNavigationBar Example',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class CustomDrawer extends SlideTransition {
  final Animation animation;
  final Duration duration;
  final VoidCallback onClicked;

  CustomDrawer(this.animation, this.duration, this.onClicked);
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBar Demo'),
      ),
      body: Stack(
        children: <Widget>[
          NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if(notification.direction == ScrollDirection.forward) {
                _animationController.forward();
              }
              if(notification.direction == ScrollDirection.reverse) {
                _animationController.reverse();
              }
              return true;
            },
            child: IndexedStack(
              index: _currentPage,
              children: <Widget>[
                FirstPage(),
                SecondPage(),
                ThirdPage()
              ],
            ) 
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SizeTransition(
                  axisAlignment: -1,
                  sizeFactor: _animationController,
                  child: child
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(height: 1.0, color: Colors.grey[300],),
                  Container(
                   color: Colors.white, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.home, color: _currentPage == 0 ? Colors.red : Colors.black54,),
                          onPressed: () {
                            setState(() {
                             _currentPage = 0; 
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.search,color: _currentPage == 1 ? Colors.red : Colors.black54),
                          onPressed: () {
                            setState(() {
                             _currentPage = 1; 
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.person, color: _currentPage == 2 ? Colors.red : Colors.black54),
                          onPressed: () {
                            setState(() {
                             _currentPage = 2; 
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        for(int i = index; i < 20; i++) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Text('Page: 0, Item $i')),
            )
          );
        }
      },
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        for(int i = index; i < 20; i++) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Text('Page: 1, Item $i')),
            )
          );
        }
      },
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        for(int i = index; i < 20; i++) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Text('Page: 2, Item $i')),
            )
          );
        }
      },
    );
  }
}
