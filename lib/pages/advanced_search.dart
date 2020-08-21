import 'package:NewsApp_Chingu/models/model_repo.dart';
import 'package:NewsApp_Chingu/models/utils/languages_and_sortBy.dart';
import 'package:NewsApp_Chingu/pages/search_result_page.dart';
import 'package:NewsApp_Chingu/widgets/platform_specific.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancedSearchPage extends StatefulWidget {
  @override
  _AdvancedSearchPageState createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage> {
  String repository;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<ModelRepository>(context);
    print("rebuilding...");
    return Scaffold(
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
                      repository.setPicker(dateTime);
                      print(repository.range);
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
                          repository.setPicker2(dateTime);
                        },
                        child: Text("to"))),
              ],
            ),
            Consumer<ModelRepository>(builder: (context, repo, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButton<String>(
                      icon: Icon(Icons.category),
                      hint: Text(repo.sortBy ?? "Select SortBy"),
                      items: Data.dropItemsPop.map((value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String value) {
                        repo.selectSortBy(value);
                      }),
                  SizedBox(
                    width: 30,
                  ),
                  DropdownButton<String>(
                      icon: Icon(Icons.language),
                      hint: Text(repo.selectedLanguage ?? "Select Language"),
                      items: Data.dropItemsLang.map((value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (String value) {
                        repo.selectLanguage(value);
                      }),
                ],
              );
            }),
            FlatButton(
              textColor: Colors.white,
              color: Colors.indigo,
              onPressed: () {
                repository
                    .getAdvancedSearchedList(
                  from: repository.range,
                  to: repository.range2,
                  lang: repository.selectedLanguage,
                  sortBy: repository.sortBy,
                  query: controller.text,
                )
                    .then(
                  (value) {
                    Navigator.of(context).push(
                      platformSpecificNavigation(
                        page: SearchResultPage(
                          searchedquery: controller.text,
                          searchedlist: value,
                        ),
                      ),
                    );
                    repository.isSearchingToFalse = false;
                  },
                );
              },
              child: Text(
                "Search",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: repository.isSearching == true
                  ? CircularProgressIndicator()
                  : Container(),
            )
          ],
        )),
      ),
    );
  }
}
