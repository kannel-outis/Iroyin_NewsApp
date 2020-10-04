import '../../../app/enums/enums.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../ui/const/color.dart';
import '../../../ui/pages/favorites/favorite_model.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../ui/pages/home/news_model_structure.dart';
import '../../../ui/widgets/article_of_the_day.dart';
import '../../../ui/widgets/custom_list_items.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller;
  Box<Favorite> favoriteBox;
  int randomIndex;
  @override
  void initState() {
    super.initState();
    favoriteBox = HomeViewModel().favOp();
    controller = TextEditingController();
    randomIndex = math.Random().nextInt(99);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) {
          var deviceHeight = MediaQuery.of(context).size.height;
          var deviceWidth = MediaQuery.of(context).size.width;
          return ConnectivityWidgetWrapper(
            child: buildScaffold(
              context,
              model.articles,
              model,
              _formKey,
              _scaffoldKey,
              deviceHeight,
              deviceWidth,
            ),
          );
        });
  }

  Scaffold buildScaffold(
    BuildContext context,
    List<Article> articles,
    HomeViewModel model,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    double deviceHeight,
    double deviceWidth,
  ) {
    return Scaffold(
      key: scaffoldKey,
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
                    model.navigate(Routes.favoritesPage);
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
                    model.navigate(Routes.advancedSearchPage);
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
      body: ModalProgressHUD(
        inAsyncCall: model.isSearching,
        opacity: 0.6,
        color: constColor3,
        child: RefreshIndicator(
          displacement: 5.0,
          onRefresh: model.articleList,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: (deviceHeight * .9) /
                            (deviceHeight <= 600 ? 70 : 40),
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
                              width: (deviceWidth * .9) / 34,
                            ),
                            Container(
                              width: deviceWidth - 130,
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  controller: controller,
                                  textInputAction: TextInputAction.search,
                                  enableSuggestions: true,
                                  cursorColor: fieldcolor,
                                  style: TextStyle(
                                      fontSize: deviceHeight <= 600 ? 18 : 23),
                                  decoration: InputDecoration(
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                      color: Color(0xFFbababa),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(bottom: -15, left: 5),
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
                                      model.navigate(
                                        Routes.searchResultPage,
                                        isSearch: true,
                                        query: controller.text,
                                        snack: () {
                                          scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: Text("No results found"),
                                            ),
                                          );
                                        },
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
                        height: (deviceHeight * .9) /
                            (deviceHeight <= 600 ? 45 : 40),
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
                                model.navigate(Routes.allArticlesPage,
                                    isSearch: false,
                                    allArticlesPage: true,
                                    detailsPageArgsFor: DetailsPageArgsFor
                                        .detailsPageAllArticles);
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
                        height: (deviceHeight * .9) / 40,
                      ),
                      Container(
                        height: deviceHeight * .26,
                        child: articles != null
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      model.navigate(
                                        Routes.detailsPage,
                                        detailsPageArgsFor: DetailsPageArgsFor
                                            .detailsPageHomepage,
                                        index: index,
                                        isSearch: false,
                                      );
                                    },
                                    child: CustomListItems(
                                        articles: articles, index: index),
                                  );
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                      SizedBox(
                          height: (deviceHeight * .9) /
                              (deviceHeight <= 600 ? 30 : 20)),
                      Row(
                        children: <Widget>[
                          Text(
                            "Article of the day",
                            style: TextStyle(
                              fontSize: deviceHeight <= 600 ? 18 : 23,
                            ),
                          ),
                        ],
                      ),
                      ArticleOfTheDay(
                          favoriteBox, randomIndex, articles, model),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
