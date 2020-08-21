import 'package:NewsApp_Chingu/const/color.dart';
import 'package:NewsApp_Chingu/const/cutter.dart';
import 'package:NewsApp_Chingu/main.dart';
import 'package:NewsApp_Chingu/models/favorite_model.dart';
import 'package:NewsApp_Chingu/models/model_repo.dart';
import 'package:NewsApp_Chingu/models/news_model_structure.dart';
import 'package:NewsApp_Chingu/pages/advanced_search.dart';
import 'package:NewsApp_Chingu/pages/all_articles_page.dart';
import 'package:NewsApp_Chingu/pages/details_news_page.dart';
import 'package:NewsApp_Chingu/pages/favorites.dart';
import 'package:NewsApp_Chingu/pages/search_result_page.dart';
import 'package:NewsApp_Chingu/widgets/article_of_the_day.dart';
import 'package:NewsApp_Chingu/widgets/platform_specific.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller;
  Box<Favorite> favoriteBox;
  int randomIndex;
  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box<Favorite>(favoriteBoxName);
    controller = TextEditingController();
    randomIndex = math.Random().nextInt(99);
  }

  ///temp

  Widget customListItems(List<Article> articles, int index) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 170,
      child: Card(
        child: Column(
          children: [
            Container(
              height: 802 * .149,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
              ),
              child: Hero(
                tag: index.toString(),
                transitionOnUserGestures: true,
                child: FadeInImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill,
                  placeholder: AssetImage("assets/placeHolderImage.png"),
                  image: CachedNetworkImageProvider(
                      "${articles[index].articleUrlToImage}"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: constColor2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("${articleTitle(index, articles)}",
                          style: TextStyle(fontSize: 13, color: Colors.white)),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "${articleAuthor(index, articles)}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //401 = width
  //802 = height

  @override
  Widget build(BuildContext context) {
    final List<Article> articles = Provider.of<List<Article>>(context);
    final ModelRepository modelRepository =
        Provider.of<ModelRepository>(context, listen: false);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    print(randomIndex);
    return buildScaffold(
      context,
      articles,
      modelRepository,
      _formKey,
      _scaffoldKey,
    );
  }

  Scaffold buildScaffold(
      BuildContext context,
      List<Article> articles,
      ModelRepository modelRepository,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constColor1,
        title: Text(
          "Dashboard",
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              child: FadeInImage(
                placeholder: AssetImage("assets/placeHolderImage.png"),
                image: AssetImage("assets/iCIzLa.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        platformSpecificNavigation(page: FavoritesPage()));
                  },
                  trailing: Icon(
                    Icons.favorite,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Favorites",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        platformSpecificNavigation(page: AdvancedSearchPage()));
                  },
                  trailing: Icon(
                    Icons.search,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Advance search",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer<ModelRepository>(
        builder: (context, modelRepository, child) {
          return ModalProgressHUD(
            inAsyncCall: modelRepository.isSearching,
            opacity: 0.6,
            color: constColor3,
            child: RefreshIndicator(
              onRefresh: () {
                return null;
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
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
                                  width: 401.0 - 130,
                                  child: Form(
                                    key: formKey,
                                    child: TextFormField(
                                      controller: controller,
                                      textInputAction: TextInputAction.search,
                                      enableSuggestions: true,
                                      cursorColor: fieldcolor,
                                      style: TextStyle(fontSize: 23),
                                      decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          color: Color(0xFFbababa),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            bottom: -15, left: 5),
                                        focusColor: fieldcolor,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: fieldcolor,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                      validator: (String value) {
                                        if (value.length == 0) {
                                          return "Field Cant be empty";
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (String value) {
                                        if (formKey.currentState.validate()) {
                                          modelRepository
                                              .getsearchedList(controller.text)
                                              .then((value) {
                                            if (value.length != 0) {
                                              final String queryText =
                                                  controller.text;
                                              Navigator.of(context).push(
                                                  platformSpecificNavigation(
                                                      page: SearchResultPage(
                                                searchedlist: value,
                                                searchedquery: queryText,
                                              )));
                                              modelRepository
                                                  .isSearchingToFalse = false;
                                              controller.clear();
                                            } else if (value.length == 0) {
                                              modelRepository
                                                  .isSearchingToFalse = false;
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text("No results found"),
                                              ));
                                            }
                                          });
                                        } else {
                                          scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "search Field cant be empty"),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Articles",
                                  style: TextStyle(fontSize: 17),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        platformSpecificNavigation(
                                            page: AllArticlesPage()));
                                  },
                                  child: Text(
                                    "All Articles",
                                    style: TextStyle(
                                        color: Color(0xFF3e9feb), fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 802 * .25,
                            child: articles != null
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            platformSpecificNavigation(
                                              page: DetailsPage(
                                                index: index,
                                                articleAuthor: articles[index]
                                                    .articleAuthor,
                                                articleContent: articles[index]
                                                    .articleContent,
                                                articleDescription:
                                                    articles[index]
                                                        .articleDescription,
                                                articlePublishedAT:
                                                    articles[index]
                                                        .articlePublishedAT,
                                                articleTitle: articles[index]
                                                    .articleTitle,
                                                articleUrl:
                                                    articles[index].articleUrl,
                                                articleUrlToImage:
                                                    articles[index]
                                                        .articleUrlToImage,
                                              ),
                                            ),
                                          );
                                        },
                                        child: customListItems(articles, index),
                                      );
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: <Widget>[
                              Text(
                                "Article of the day",
                                style: TextStyle(
                                  fontSize: 23,
                                ),
                              ),
                            ],
                          ),
                          ArticleOfTheDay(favoriteBox, randomIndex),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
