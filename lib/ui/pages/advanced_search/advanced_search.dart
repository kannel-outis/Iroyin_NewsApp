import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/utils/languages_and_sortBy.dart';
import '../../../ui/pages/advanced_search/advanced_search_viewModel.dart';
import '../../../ui/custom/widgets/platform_specific.dart';
import 'package:flutter/material.dart';

final advancedSearchViewModel =
    ChangeNotifierProvider<AdvancedSearchViewModel>((ref) {
  return AdvancedSearchViewModel();
});

class AdvancedSearchPage extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final model = useProvider(advancedSearchViewModel);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0, title: Text("Advanced Search")),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: PlatformSpec.platFormTextfield(controller: controller),
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
                      await PlatformSpec.dateTime(context, model.setPicker);
                    },
                  ),
                ),
                Container(
                  child: PlatformSpec.platFormButton(
                    text: "To",
                    onPressed: () async {
                      await PlatformSpec.dateTime(context, model.setPicker2);
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                PlatformSpec.optionDropOrPick(
                  Icons.category,
                  context: context,
                  modelString: model.sortBy,
                  options: Data.dropItemsPop,
                  selectSide: model.selectSortBy,
                  selectOption: "select category",
                ),
                SizedBox(
                  width: 30,
                ),
                PlatformSpec.optionDropOrPick(
                  Icons.language,
                  context: context,
                  modelString: model.selectedLanguage,
                  options: Data.dropItemsLang,
                  selectSide: model.selectLanguage,
                  selectOption: "select Language",
                )
              ],
            ),
            PlatformSpec.platFormButton(
              text: "Search",
              onPressed: () {
                model.navigate(
                  query: controller.text,
                  snack: () {
                    _messengerKey.currentState!
                        .showSnackBar(SnackBar(content: Text("No Results")));
                    model.setIsSearching = false;
                  },
                );
              },
            ),
            SizedBox(height: 10),
            Consumer(builder: (context, watch, child) {
              final isSearching = watch(advancedSearchViewModel).isSearching;
              return Center(
                child: isSearching == true
                    ? CircularProgressIndicator(
                        strokeWidth: 2.0,
                      )
                    : Container(),
              );
            })
          ],
        )),
      ),
    );
  }
}
