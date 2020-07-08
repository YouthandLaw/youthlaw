import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youthlaw/HomeInfo.dart';
import 'package:youthlaw/HomePage.dart';
import 'package:youthlaw/NavigationBar.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:youthlaw/PeopleInfo.dart';
import 'package:youthlaw/PictureInfo.dart';
import 'package:youthlaw/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;


class HomeContentDesktop extends StatefulWidget {
  HomeContentDesktop({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomeContentDesktopState createState() => HomeContentDesktopState();
}

class HomeContentDesktopState extends State<HomeContentDesktop> {
//  var _dateNow = new DateTime.now();
//  Timer _timer;
//  int day;
//  int hour;
//  int minute;
//  int sec;
//
////  int day = globals.days;
////  int hour = globals.hours;
////  int minute = globals.minutes;
////  int sec = globals.secs;
//
//  void _startTimerDesktop(){
//    var difference = globals.eventDate.difference(_dateNow);
////    globals.days = difference.inDays;
////    globals.hours = difference.inHours % 24;
////    globals.minutes = difference.inMinutes % 60;
////    globals.secs = difference.inSeconds % 60;
//    day = difference.inDays;
//    hour = difference.inHours % 24;
//    minute = difference.inMinutes % 60;
//    sec = difference.inSeconds % 60;
//
//    if (_timer != null) {
//      _timer.cancel();
//    }
//    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//      setState(() {
//        if (day == 0 && hour == 0 && minute == 0 && sec == 0){
//          _timer.cancel();
//        }
//        else{
//          if(sec > 0)  {
//            sec--;
//          }
//          else if(sec == 0) {
//            if(minute > 0){
//              minute--;
//              sec = 59;
//            }
//            else if(minute == 0){
//              if (hour > 0){
//                hour--;
//                minute = 59;
//                sec = 59;
//              }
//              else if (hour == 0){
//                if (day > 0){
//                  day--;
//                  hour = 23;
//                  minute = 59;
//                  sec = 59;
//                }
//                else if(day == 0){
//                  _timer.cancel();
//                }
//              }
//            }
//          }
//        }
//      });
//    });
//  }


  Widget PageContent;

  List<MenuInfo> _Menu = List<MenuInfo>();
  Future<List<MenuInfo>> fetchMenuInfo() async {
    var url = 'https://raw.githubusercontent.com/101Ben/YLFContent/master/contentJson/homeMessage.json';
    var response = await http.get(url);

    var cards = List<MenuInfo>();

    if (response.statusCode == 200){
      var cardsJson = json.decode(response.body);
      for (var cardJson in cardsJson) {
        cards.add(MenuInfo.fromJson(cardJson));
      }
    }
    return cards;
  }

  List<PicInfo> _pictures = List<PicInfo>();
  Future<List<PicInfo>> fetchPicInfo() async {
    var url = 'https://raw.githubusercontent.com/101Ben/YLFContent/master/contentJson/galleryLink.json';
    var response = await http.get(url);

    var cards = List<PicInfo>();

    if (response.statusCode == 200){
      var cardsJson = json.decode(response.body);
      for (var cardJson in cardsJson) {
        cards.add(PicInfo.fromJson(cardJson));
      }
    }
    return cards;
  }

  List<PeopleInfo> _people = List<PeopleInfo>();
  Future<List<PeopleInfo>> fetchPeopleInfo() async {
    var url = 'https://raw.githubusercontent.com/101Ben/YLFContent/master/contentJson/peopleBio.json';
    var response = await http.get(url);
    var cards = List<PeopleInfo>();
    if (response.statusCode == 200){
      var cardsJson = json.decode(response.body);
      for (var cardJson in cardsJson) {
        cards.add(PeopleInfo.fromJson(cardJson));
      }
    }
    return cards;
  }

  @override
  void initState(){
//    _startTimerDesktop();
//    fetchMenuInfo().then((value){
//      setState(() {
//        _Menu.addAll(value);
//        switch(globals.currentPage){
//          case 1:
//            {
//              PageContent = homeLink();
//            }
//            break;
//          case 2:
//            {
//              PageContent = infoLink();
//            }
//            break;
//          case 3:
//            {
//              PageContent = forumLink();
//            }
//            break;
//          case 4:
//            {
//              PageContent = historyLink();
//            }
//            break;
//          case 5:
//            {
//              PageContent = sponsorsLink();
//            }
//            break;
//          default:
//            {
//              PageContent = galleryLink();
//            }
//            break;
//        }
//      });
//    });
    fetchPeopleInfo().then((people){
      setState(() {
        _people.addAll(people);
      });
    });
    fetchPicInfo().then((entry){
      setState(() {
        _pictures.addAll(entry);
      });
    });
    super.initState();
  }

  void downloadFile(String url){
    html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }


  Widget homeLink(){
    return Container(
      child: Column(
        children: <Widget> [
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                //margin: const EdgeInsets.all(12),
                child: Image.network(
                    'https://raw.githubusercontent.com/101Ben/YLFContent/master/front.png',
                fit: BoxFit.cover,),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Center(
                  child: Text(
                    "Youth & Law Forum\nSeattle",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 80,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 32.0, left: 12.0),
            child: Text(
              "Upcoming Events",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 32.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(),
          Row(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                margin: const EdgeInsets.all(22),
                child: Image.network(
                    'https://raw.githubusercontent.com/101Ben/YLFContent/master/banner.png',
                fit: BoxFit.fill,width: 400, height: 400, semanticLabel: "2020 Forum",),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  child: SelectableText(
                    globals.homeMessage,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          FlatButton(
            hoverColor: Colors.grey,
            //color: Colors.greenAccent,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12)
            ),
            child: Text(
              "Information and Registration here",
              style: TextStyle(
                  fontSize: 20,
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.italic
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: (){
              setState(() {
                globals.currentPage = 3;
                PageContent = forumLink();
              });
            },
          ),
          SizedBox(
            height: 400.0,
          ),
          BottomPage(),
        ],
      ),
    );
  }

  Widget infoLink(){
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            header("Information"),
            Divider(),
            Text(
              "What is it",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 128.0),
                child: SelectableText(
                  globals.whatIsIt,
                  scrollPhysics: BouncingScrollPhysics(),
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1000.0,
            ),
            BottomPage(),
          ],
        )
      ),
    );
  }

  Widget contentImage = Column(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        margin: const EdgeInsets.all(12),
        child: Image.network(
            'https://raw.githubusercontent.com/101Ben/YLFContent/master/assetslogo/scheduleOne.png'),
      ),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        margin: const EdgeInsets.all(12),
        child: Image.network(
            'https://raw.githubusercontent.com/101Ben/YLFContent/master/assetslogo/scheduleTwo.png'),
      ),
    ],
  );

  Widget forumLink(){
    List<PeopleInfo> _speakers = List<PeopleInfo>();
    for(var temp in _people){
      if(temp.group == "speaker20") {
        _speakers.add(temp);
      }
    }
    double _scale = 1.0;
    double _previousScale = 1.0;
    return Container(
      child: Center(
        child: Column(
          children: [
            header("The Power in Each of us a Flame"),
            Divider(),
            Container(
              width: 400,
              padding: EdgeInsets.only(left: 70.0) ,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: 70,
              //width: 140,
              child: Center(child: countDown()),
            ),
            SizedBox(
              child: SelectableText(
                'Date: September 26, 2020',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  backgroundColor: Colors.white12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  hoverColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12)
                  ),
                  child: Text(
                    "Schedule",
                    style: TextStyle(
                        fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: (){
                    setState(() {
                      contentImage = Column(
                        children: <Widget>[
                          GestureDetector(
                            onScaleStart: (ScaleStartDetails details) {
                              print(details);
                              _previousScale = _scale;
                              setState(() {});
                            },
                            onScaleUpdate: (ScaleUpdateDetails details) {
                              print(details);
                              _scale = _previousScale * details.scale;
                              setState(() {});
                            },
                            onScaleEnd: (ScaleEndDetails details) {
                              print(details);

                              _previousScale = 1.0;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              margin: const EdgeInsets.all(12),
                              child: Transform(
                                alignment: FractionalOffset.center,
                                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                                child: Image.network(
                                    'https://raw.githubusercontent.com/101Ben/YLFContent/master/assetslogo/scheduleOne.png'),
                              ),
                            ),
                          ),
//                          Container(
//                          decoration: BoxDecoration(
//                            shape: BoxShape.rectangle,
//                          ),
//                            margin: const EdgeInsets.all(12),
//                            child: Image.network(
//                          'https://raw.githubusercontent.com/101Ben/YLFContent/master/assetslogo/scheduleOne.png'),
//                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            margin: const EdgeInsets.all(12),
                            child: Image.network(
                                'https://raw.githubusercontent.com/101Ben/YLFContent/master/assetslogo/scheduleTwo.png',
                            fit: BoxFit.fill,),
                          ),
                        ],
                      );
                    });
                    build(context);
                  },
                ),
                FlatButton(
                  hoverColor: Colors.grey,
//                  color: Colors.greenAccent,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12)
                  ),
                  child: Text(
                    "Register HERE",
                    style: TextStyle(
                        fontSize: 20,
                      decoration: TextDecoration.underline,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  onPressed: _launchURL,
                ),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12)
                  ),
                  hoverColor: Colors.grey,
                  child: Text(
                    "Speaker Bio",
                    style: TextStyle(
                        fontSize: 20,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: (){
                    setState(() {
                      contentImage = Container(
                        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 128.0),
                        child: Column(
                          children: [
                            for (var i = 0; i < _speakers.length; i++)
                          leaderCard(_speakers[i].link, _speakers[i].name, _speakers[i].bio),
                          ],
                        ),
//                        Container(
//                          height: 540.0,
//                          child:
//                          ListView.builder(
//                            scrollDirection: Axis.vertical,
//                            itemCount: _speakers.length,
//                            itemBuilder: (context, index){
//                              return
//                                leaderCard(_speakers[index].link, _speakers[index].name, _speakers[index].bio);
//                            },
//                          ),
//                        ),
                      );
                    });
                    build(context);
                  },
                ),
              ],
            ),
            Divider(),
            Container(
              child: contentImage,
            ),
            FlatButton(
              child: Text(
                'DownLoad Schedule',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),),
              onPressed: (){
                downloadFile('https://github.com/101Ben/YLFContent/raw/master/ylf%202020%20schedule.pdf');
              },
            ),
            SizedBox(
              height: 200.0,
            ),
            BottomPage(),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://forms.gle/n6EQ8fP3L9TtBLN67';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget historyLink(){
    List<PeopleInfo> _leaders = List<PeopleInfo>();
    for(var temp in _people){
      if(temp.group == "leader") {
        _leaders.add(temp);
      }
    }
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            header("Leader Board"),
            Divider(),
            SelectableText(
              "Objectives",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 128.0),
                child: SelectableText(
                  globals.objectives,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Divider(),
            SelectableText(
                "History",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 128.0),
                child: SelectableText(
                  globals.history,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Divider(),
            Text(
              "Leaders",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24
              ),
            ),
            Container(
//              height: 6000.0,
              padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 128.0),
              child:
              Column(
                children: [
                  for (var i = 0; i < _leaders.length; i++)
                    leaderCard(_leaders[i].link, _leaders[i].name, _leaders[i].bio),
                ],
              ),
//              ListView.builder(
//                scrollDirection: Axis.vertical,
//                itemCount: _leaders.length,
//                itemBuilder: (context, index){
//                  return
//                    leaderCard(_leaders[index].link, _leaders[index].name, _leaders[index].bio);
//                },
//              ),
            ),
            SizedBox(
              height: 140.0,
            ),
            BottomPage(),
          ],
        ),
      ),
    );
  }

  Widget sponsorsLink(){
    List<String> logo = List<String>();
    for (var temp in _pictures){
      if (temp.group == "logo") logo.add(temp.picLink);
    }

    return Container(
      child: Center(
          child: Column(
            children: <Widget>[
              header("Our Sponsors"),
              Divider(),
              for (var i = 0; i < logo.length; i++) Container(
                width: 300.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                margin: const EdgeInsets.all(32),
                child: Image.network(logo[i], fit: BoxFit.cover),
              ),
//              Container(
//                height: 500.0,
//                color: Colors.grey,
//                margin: EdgeInsets.symmetric(horizontal: 18.0),
//                child: GridView.builder(
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 6,
//                    crossAxisSpacing: 5.0,
//                    mainAxisSpacing: 4.0,
//                    childAspectRatio: 0.9,
//                  ),
//                    itemCount: logo.length,
//                    itemBuilder: (context, index){
//                      return Container(
//                        width: 100.0,
//                        decoration: BoxDecoration(
//                          shape: BoxShape.rectangle,
//                        ),
//                        margin: const EdgeInsets.all(12),
//                        child: Image.network(logo[index], fit:BoxFit.fill),
//                      );
//                    },
//                  ),
//                  //scrollDirection: Axis.vertical,
//                ),
              SizedBox(
                height: 100.0,
              ),
              BottomPage(),
            ],
          )
      ),
    );
  }

  Widget galleryLink(){
    List<String> other = List<String>();
    List<String> pic2017 = List<String>();
    List<String> picSeaH = List<String>();

    for (var temp in _pictures){
      if (temp.group == "other") other.add(temp.picLink);
      else if (temp.group == "2017") pic2017.add(temp.picLink);
      else if (temp.group == "sea") picSeaH.add(temp.picLink);
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header("Memories and Activities"),
//          Container(
//            height: 100.0,
//            child: ListView.builder(
//              scrollDirection: Axis.horizontal,
//              itemCount: 18,
//              itemBuilder: (context, index){
//                return Container(
//                  width: 100.0,
//                  color: Colors.primaries[index],
//                );
//              },
//            ),
//          ),
          Divider(),
          Text("Youth and Law Forum - Session of 2017", style: TextStyle(fontWeight: FontWeight.bold),),
          Container(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pic2017.length,
              itemBuilder: (context, index){
                return
                  Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    margin: const EdgeInsets.all(12),
                    child: Image.network(pic2017[index], fit:BoxFit.fill),
                  );
              },
            ),
          ),
          Divider(),
          Text("Youth and Law Forum - Seahawks Traning Camp in 2017", style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: picSeaH.length,
              itemBuilder: (context, index){
                return
                  Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    margin: const EdgeInsets.all(12),
                    child: Image.network(picSeaH[index], fit:BoxFit.fill),
                  );
              },
            ),
          ),
          Divider(),
          Text("Youth and Law Forum - Session of 2016",style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: other.length,
              itemBuilder: (context, index){
                return
                  Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    margin: const EdgeInsets.all(12),
                    child: Image.network(other[index], fit:BoxFit.fill),
                  );
              },
            ),
          ),
          SizedBox(
            height: 300.0,
          ),
          BottomPage(),
        ],
      ),
    );

    List<Container> _buildGridTileList(int count) => List.generate(
        count, (i) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  margin: const EdgeInsets.all(12),
                  child: Image.network(_pictures[i].picLink),
                ));
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildGridTileList(_pictures.length),
      ),
    );
  }

  Widget header(String text){
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 180.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          //margin: const EdgeInsets.all(12),
          child: Image.network(
            'https://raw.githubusercontent.com/101Ben/YLFContent/master/front.png',
            fit: BoxFit.cover,),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Center(
                child: Text(
                  "Youth & Law Forum",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 80,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget countDown(){
    int day = globals.days;
    int hour = globals.hours;
    int minute = globals.minutes;
    int sec = globals.secs;
    return Container(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$day :',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                'days',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ' $hour :',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                'hours',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ' $minute :',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                'minutes',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ' $sec',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                ' seconds',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //if (globals.currentPage == 3 )PageContent = forumLink();
//    switch(globals.currentPage){
//      case 1:
//        {
//          PageContent = homeLink();
//        }
//        break;
//      case 2:
//        {
//          PageContent = infoLink();
//        }
//        break;
//      case 3:
//        {
//          PageContent = forumLink();
//        }
//        break;
//      case 4:
//        {
//          PageContent = historyLink();
//        }
//        break;
//      case 5:
//        {
//          PageContent = sponsorsLink();
//        }
//        break;
//      default:
//        {
//          PageContent = galleryLink();
//        }
//        break;
//    }
    // TODO: implement build
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: NavigationBar(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child:
                      SelectableText(
                        "Judge Charles V. Johnson",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          fontSize: 38,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child:
                    globals.currentPage == 1 ? homeLink() :
                      (globals.currentPage == 2 ? infoLink() :
                        globals.currentPage == 3 ? forumLink() :
                        globals.currentPage == 4 ? historyLink() :
                        globals.currentPage == 5 ? sponsorsLink() : galleryLink()), //PageContent ,
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


class leaderCard extends StatelessWidget{

  String link;
  String name;
  String message;
  leaderCard(String lnk, String nm, String msg){
    link = lnk;
    name = nm;
    message = msg;
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
        child: Row(
          children: <Widget>[
            Container(
                width: 120.0,
                height: 120.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      //fit: BoxFit.fill,
                      image: new NetworkImage(link),
                    )
                )
            ),
            Divider(),
            Expanded(
              child: SizedBox(
                child: ListTile(
                  title:
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),),
                  subtitle: Text(
                      "\n" + message,
                      style: TextStyle(
                        fontSize: 14,
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 18.0, left: 40.0, right: 40.0),
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact information\n",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              SelectableText(
                'Phone: (206) 257-5572\n',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SelectableText(
                'email: ...@youthandlaw.com\n',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SelectableText(
                'Address: 1522 14th Ave,\nSeattle, WA\n98122\n',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Connect on Social Media",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              FlatButton(
                child:
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  margin: const EdgeInsets.all(1.0),
                  child: Image.network(
                      'https://raw.githubusercontent.com/101Ben/YLFContent/master/faceIcon.png', fit: BoxFit.fill),
                ),
                onPressed: _launchFaceBookURL, /// provide facebook link
              ),
              FlatButton(
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  margin: const EdgeInsets.all(1.0),
                  child: Image.network(
                      'https://raw.githubusercontent.com/101Ben/YLFContent/master/twittweIcon.png', fit: BoxFit.fill),
                ),
                onPressed: _launchTweetURL, /// provide twitter link
              ),
              FlatButton(
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  margin: const EdgeInsets.all(1.0),
                  child: Image.network(
                      'https://raw.githubusercontent.com/101Ben/YLFContent/master/InstaIcon.png', fit: BoxFit.fill),
                ),
                onPressed: _launchInstaURL, /// provide instagram link
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(),
              Text(
                "All right reserved • 2020" ,
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
  _launchFaceBookURL() async {
    const url = 'https://www.facebook.com/youthandlaw/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchInstaURL() async {
    const url = 'https://instagram.com/theyouthandlawforum?igshid=1pjt1j4t49vnl';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchTweetURL() async {
    const url = 'https://twitter.com/youthlawforum?lang=en';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

/// this is the order of the Number
/// 1 -> Home
/// 2 -> Information
/// 3 -> Annual Forum
/// 4 -> Founders
/// 5 -> Sponsors
/// 6 -> Gallery
