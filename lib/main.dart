import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
        primarySwatch: Colors.blue,
    ),
    home: new MyHomePage(title: 'ListView with Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  var mainDataItems = ["One","Two","Three","Four","Five","Six"];
  var duplicateItems = List<String>();
//  final duplicateItems = ["Apple","Ball","Cat","Dog","Elephant","Frog","Goat","Hen","Ink","Jugle","Kite","Lemon","Mango","Nest","Open","Post Office","Queen","Rose","Sugar","Ten","Universe","Van","White","Xlylophone","Yolk","Zebra"];
  var items = List<String>();
  List<bool> textColor = [];
  var searchTextFieldEnteredText;

  @override
  void initState() {
    duplicateItems.addAll(mainDataItems);
    items.addAll(mainDataItems);

//    print("Init State Items:$items");
//    print("Init State Shuffled Items:$shuffledItems");

    for (int i = 0; i < duplicateItems.length; i++){
      textColor.add(true);
    }

    super.initState();
  }

  void filterSearchResults(String query) {

    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {

      print("Search Text Field is not empty");

      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;

    } else {

      //This calls when we remove entered text in Search Text Field
      print("Search Text Field is empty");

      setState(() {

        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  searchTextFieldEnteredText = value;
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
//                      print("Tapped");

                    if (searchTextFieldEnteredText == null) {
                      print("Search Field is Inactive");

                      setState(() {
//                        textColor[0] = false;
                        items.insert(0, items[index]);
                        items.removeAt(index + 1);
                      });
                      searchTextFieldEnteredText = null;
                      print("Nikhil Items when search Field is inactive:$items");


                    }else if (searchTextFieldEnteredText != null){
                      print("Search Field is Active");

                      print("Hello Items when search Field is active:$items");

                      print("Selected Item:${items[index]}");

                      setState(() {

                        items.clear();
                        items.addAll(duplicateItems);
                      });
                    }

//                      _scrollController.animateTo(
//                        0.0,
//                        curve: Curves.easeOut,
//                        duration: const Duration(milliseconds: 500),
//                      );
                    },
                    title: Text('${items[index]}',style: TextStyle(color: textColor[index] ? Colors.black : Colors.red),),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}