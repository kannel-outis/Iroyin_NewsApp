import 'package:NewsApp_Chingu/const/color.dart';
import 'package:NewsApp_Chingu/methods/functions.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Functions functions = Functions();
  @override
  void initState() {
    super.initState();
    // functions.getNewsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<List<Article>>(context);
    functions.getNewsFromApi();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Dashboard",
        ),
      ),
      drawer: Drawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.search,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 130,
                      child: TextFormField(
                        cursorColor: fieldcolor,
                        style: TextStyle(fontSize: 23),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Color(0xFFbababa),
                          ),
                          contentPadding: EdgeInsets.only(bottom: -15, left: 5),
                          focusColor: fieldcolor,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: fieldcolor, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Articles",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "All Articles",
                      style: TextStyle(color: Color(0xFF3e9feb), fontSize: 17),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // PageView.builder(itemBuilder: null,),
              Container(
                  height: 258,
                  child: articles != null
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 200,
                              child: Card(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          image: DecorationImage(
                                              alignment: Alignment.topCenter,
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  articles[index]
                                                      .articleUrlToImage))),
                                    ),
                                    Container(
                                      height: 100,
                                      width: double.infinity,
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
