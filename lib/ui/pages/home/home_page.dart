import 'package:NewsApp_Chingu/app/style/wrapper_refresher.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/enums/enums.dart';
import '../../../app/routes/route_generator.gr.dart';
import '../../../ui/const/color.dart';
import '../../../models/favorite_model.dart';
import '../../../ui/pages/home/Home_viewModel.dart';
import '../../../models/news_model_structure.dart';
import '../../../ui/custom/widgets/article_of_the_day.dart';
import '../../../ui/custom/widgets/custom_list_items.dart';
// import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:math' as math;

// Provider
final homeViewModel = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel();
});
final randomIndex = Provider<int>((ref) {
  return math.Random().nextInt(99) + 0;
});
final futureHomeViewModel = FutureProvider.autoDispose<List<Article>>((ref) {
  return ref.read(homeViewModel).articleList();
});

class MyHomePage extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _textEditingController;
  late final Box<Favorite> _favoriteBox;
  late final GlobalKey<ScaffoldMessengerState> _messengerKey;
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  void initState() {
    super.initState();
    _favoriteBox = HomeViewModel().favOp();
    _messengerKey = GlobalKey<ScaffoldMessengerState>();
    _scaffoldKey = GlobalKey<ScaffoldState>();

    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return BuildScaffold(
      context: context,
      // articles: model.articles ?? [],
      // model: model,
      formKey: MyHomePage._formKey,
      scaffoldKey: _scaffoldKey,
      deviceHeight: deviceHeight,
      deviceWidth: deviceWidth,
      controller: _textEditingController,
      favoriteBox: _favoriteBox,
      messengerKey: _messengerKey,
    );
  }
}

class BuildScaffold extends ConsumerWidget {
  const BuildScaffold({
    Key? key,
    required this.context,
    // required this.articles,
    // required this.model,
    required this.formKey,
    required this.scaffoldKey,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.controller,
    required this.favoriteBox,
    required this.messengerKey,
  }) : super(key: key);

  final BuildContext context;
  // final List<Article> articles;
  // final HomeViewModel model;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double deviceHeight;
  final double deviceWidth;
  final TextEditingController controller;
  final Box<Favorite> favoriteBox;
  final GlobalKey<ScaffoldMessengerState> messengerKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(homeViewModel);
    var articles = model.articles ?? [];
    return WrapperRefresher(
      child: Scaffold(
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
            onRefresh: ref.read(homeViewModel).articleList,
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
                                        fontSize:
                                            deviceHeight <= 600 ? 18 : 23),
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
                                    validator: (String? value) {
                                      if (value == null) {
                                        return "Field Cant be empty";
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (String value) {
                                      if (formKey.currentState!.validate()) {
                                        model.navigate(
                                          Routes.searchResultPage,
                                          isSearch: true,
                                          query: controller.text,
                                          call: () {
                                            controller.clear();
                                          },
                                          snack: () {
                                            messengerKey.currentState!
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text("No results found"),
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
                            child: ref.watch(futureHomeViewModel).when(
                                data: (data) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          model.navigate(
                                            Routes.detailsPage,
                                            detailsPageArgsFor:
                                                DetailsPageArgsFor
                                                    .detailsPageHomepage,
                                            index: index,
                                            isSearch: false,
                                          );
                                        },
                                        child: CustomListItems(
                                            articles: model.articles,
                                            index: index),
                                      );
                                    },
                                  );
                                },
                                loading: () => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                error: (o, s) {
                                  return Center(child: Text(o.toString()));
                                })),
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
                            favoriteBox, ref.watch(randomIndex), articles),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
