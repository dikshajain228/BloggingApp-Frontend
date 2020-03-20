import 'package:flutter/material.dart';
import 'package:bloggingapp/Posts.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => new MyHomePageState();
}

List getPosts() {
  //API Call to the backend. Static data
  List<Posts> postsList = [];
  Posts post = new Posts(
      "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "HEllo there",
      "2017-04-19",
      "17:55");
  Posts post1 = new Posts(
      "https://images.pexels.com/photos/321470/pexels-photo-321470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      "I feel lonely",
      "2017-04-19",
      "17:55");
  Posts post2 = new Posts(
      "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "I am beautiful",
      "2020-04-19",
      "17:55");
  postsList.add(post);
  postsList.add(post1);
  postsList.add(post2);
  return postsList;
}

List getQuestions() {
  //API Call to backend. Static data
  List<Posts> questions = [];

  Posts post2 = new Posts(
      "https://images.pexels.com/photos/321470/pexels-photo-321470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      "I am beautiful",
      "2020-04-19",
      "17:55");
  Posts post = new Posts(
      "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "HEllo there",
      "2017-04-19",
      "17:55");
  questions.add(post2);
  questions.add(post);
  return questions;
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  List<Posts> postsList = [];
  List<Posts> questions = [];
  final myTabs = [
    new Tab(
      text: 'Articles',
    ),
    new Tab(
      text: 'Questions',
    ),
  ];
  @override
  void initState() {
    super.initState();
    postsList = getPosts();
    questions = getQuestions();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return header(context, controller, myTabs, postsList, questions);
  }
}

Widget header(BuildContext context, TabController controller, final myTabs,
    List<Posts> postsList, List<Posts> questions) {
  //Header(appbar) with the tabs
  return new Scaffold(
    appBar: new AppBar(
      title: new Text("BloggingApp"),
    ),
    body: new ListView(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new TabBar(
            controller: controller,
            tabs: myTabs,
          ),
        ),
        new Container(
          height: 542,
          child: new TabBarView(
            controller: controller,
            children: <Widget>[
              //POSTS
              new Container(
                  child: postsList.length == 0
                      ? new Text("No Blog Post availabale")
                      : new ListView.builder(
                          itemCount: postsList.length,
                          itemBuilder: (_, index) {
                            return postsUI(
                                //List Tile cards
                                context,
                                postsList[index].image,
                                postsList[index].title,
                                postsList[index].date,
                                postsList[index].time);
                          })),
              //QUESTIONS
              new Container(
                  child: questions.length == 0
                      ? new Text("No Blog Post availabale")
                      : new ListView.builder(
                          itemCount: questions.length,
                          itemBuilder: (_, index) {
                            return postsUI(
                                context,
                                questions[index].image,
                                questions[index].title,
                                questions[index].date,
                                questions[index].time);
                          })),
            ],
          ),
        ),
      ],
    ),
  );
}

//Tiles
Widget makeListTile(BuildContext context, String image, String title,
    String date, String time) {
  return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.grey))),
        child: new Image.network(image),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: <Widget>[
          //Icon(Icons.access_alarm, color: Colors.black),
          Text(date + " | " + time, style: TextStyle(color: Colors.black))
        ],
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlePage()));
      },
  );
      
}

//Cards
Widget postsUI(BuildContext context, String image, String title, String date,
    String time) {
  //Post card
  return new Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(),
      child: makeListTile(context, image, title, date, time),
    ),
  );
}

class ArticlePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Page"),
      ),
      body: Center(
          child: Text('Page still under construction'),
        ),
      );
  }
}