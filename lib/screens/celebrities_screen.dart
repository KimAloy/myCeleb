import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:provider/provider.dart';

class CelebritiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final celebritiesList = provider.celebritiesList;
    final getSuggestions = provider.getSuggestions;
    celebritiesList.shuffle(); // this shuffles the arrangement of the list
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.info_outline, size: 20),
                  onPressed: () {
                    print('cool');
                    // TODO: Go to FAQ and Terms and Conditions screen
                  },
                ),
                Text(
                  'Celebrities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    print('login sign up tapped');
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return LoginSignUp();
                    }));
                  },
                  child: Text('Login'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 35,
                child: TypeAheadField<UserModel>(
                  hideSuggestionsOnKeyboardHide: true,
                  textFieldConfiguration: TextFieldConfiguration(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0)),
                          hintText: 'Search')),
                  suggestionsCallback: getSuggestions,
                  itemBuilder: (context, UserModel suggestion) {
                    final user = suggestion;
                    return ListTile(
                      title: Text(user.name),
                      leading: Container(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          user.profileImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (UserModel suggestion) {
                    final user = suggestion;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CelebrityDetailsPage(celebrity: user)));
                  },
                  noItemsFoundBuilder: (context) => Container(
                    height: 80,
                    child: Center(
                      child: Text(
                        'No celebrity found',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: celebritiesList.length,
                        itemBuilder: (context, index) {
                          final UserModel celebrity = celebritiesList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CelebrityDetailsPage(
                                      celebrity: celebrity)));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          child: Image.asset(
                                              celebrity.profileImage!,
                                              fit: BoxFit.cover),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: Text(
                                            '${numberCommaFormatter.format(celebrity.price)}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${celebrity.name}',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${celebrity.category![0]}',
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
