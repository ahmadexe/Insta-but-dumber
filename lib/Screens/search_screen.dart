import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/Screens/others_profile_screen.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  String _searchText = "";
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search",
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchText = "";
                  _searchController.clear();
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;
                _isSearching = !_isSearching;
              });
            },
          ),
        ),
        body: _isSearching
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isLessThanOrEqualTo: _searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index].data()['photoUrl']!),
                        ),
                        title:
                            Text(snapshot.data!.docs[index].data()['username']),
                        onTap: () {Get.to(Profile());},
                      );
                    },
                  );
                })
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        crossAxisCount: 3,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 3.3,
                          child: Card(
                            child: Image.network(
                              snapshot.data!.docs[index].data()['postUrl'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      });
                })));
  }
}
