import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/services/utils/languages_and_sortBy.dart';
import 'package:NewsApp_Chingu/ui/pages/advanced_search/advanced_search_viewModel.dart';
import 'package:NewsApp_Chingu/ui/widgets/platform_specific.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdvancedSearchPage extends StatefulWidget {
  @override
  _AdvancedSearchPageState createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage> {
  String repository;
  final TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdvancedSearchViewModel>.reactive(
        viewModelBuilder: () => AdvancedSearchViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(),
            body: Container(
              child: Center(
                  child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                    child:
                        PlatformSpec.platFormTextfield(controller: controller),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: PlatformSpec.platFormButton(
                          text: "From",
                          onPressed: () async {
                            await PlatformSpec.dateTime(
                                context, model.setPicker);
                            print(model.range);
                          },
                        ),
                      ),
                      Container(
                        child: PlatformSpec.platFormButton(
                          text: "To",
                          onPressed: () async {
                            await PlatformSpec.dateTime(
                                context, model.setPicker2);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      PlatformSpec.optionDropOrPick(Icons.category,
                          context: context,
                          modelString: model.sortBy,
                          options: Data.dropItemsPop,
                          selectSide: model.selectSortBy),
                      SizedBox(
                        width: 30,
                      ),
                      PlatformSpec.optionDropOrPick(Icons.language,
                          context: context,
                          modelString: model.selectedLanguage,
                          options: Data.dropItemsLang,
                          selectSide: model.selectLanguage)
                    ],
                  ),
                  PlatformSpec.platFormButton(
                    text: "Search",
                    onPressed: () {
                      model.setIsSearching = true;
                      model
                          .getAdvancedSearchedList(
                        from: model.range,
                        to: model.range2,
                        lang: model.selectedLanguage,
                        sortBy: model.sortBy,
                        query: controller.text,
                      )
                          .then(
                        (value) {
                          if (value.length != 0) {
                            Navigator.of(context).pushNamed(
                              Routes.searchResultPage,
                              arguments: SearchResultPageArguments(
                                searchedquery: controller.text,
                                searchedlist: value,
                              ),
                            );
                            model.setIsSearching = false;
                          } else {
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(content: Text("No Results")));
                            model.setIsSearching = false;
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: model.isSearching == true
                        ? CircularProgressIndicator(
                            strokeWidth: 2.0,
                          )
                        : Container(),
                  )
                ],
              )),
            ),
          );
        });
  }
}
