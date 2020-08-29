import 'package:NewsApp_Chingu/app/routes/route_generator.gr.dart';
import 'package:NewsApp_Chingu/services/utils/languages_and_sortBy.dart';
import 'package:NewsApp_Chingu/ui/pages/advanced_search/advanced_search_viewModel.dart';
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
                    padding: EdgeInsets.all(12.0),
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Colors.indigo,
                          onPressed: () async {
                            DateTime dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2017),
                                lastDate: DateTime.now());
                            model.setPicker(dateTime);
                            print(model.range);
                          },
                          child: Text("from"),
                        ),
                      ),
                      Container(
                          child: FlatButton(
                              textColor: Colors.white,
                              color: Colors.indigo,
                              onPressed: () async {
                                DateTime dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2017),
                                    lastDate: DateTime.now());
                                model.setPicker2(dateTime);
                              },
                              child: Text("to"))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DropdownButton<String>(
                          icon: Icon(Icons.category),
                          hint: Text(model.sortBy ?? "Select SortBy"),
                          items: Data.dropItemsPop.map((value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (String value) {
                            model.selectSortBy(value);
                          }),
                      SizedBox(
                        width: 30,
                      ),
                      DropdownButton<String>(
                          icon: Icon(Icons.language),
                          hint:
                              Text(model.selectedLanguage ?? "Select Language"),
                          items: Data.dropItemsLang.map((value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (String value) {
                            model.selectLanguage(value);
                          }),
                    ],
                  ),
                  FlatButton(
                    textColor: Colors.white,
                    color: Colors.indigo,
                    onPressed: () {
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
                            model.isSearching = false;
                          } else {
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(content: Text("No Results")));
                            model.isSearching = false;
                          }
                        },
                      );
                    },
                    child: Text(
                      "Search",
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: model.isSearching == true
                        ? CircularProgressIndicator()
                        : Container(),
                  )
                ],
              )),
            ),
          );
        });
  }
}
