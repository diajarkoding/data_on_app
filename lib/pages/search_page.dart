import 'package:data_on_app/api/api.dart';
import 'package:data_on_app/common/constant.dart';
import 'package:data_on_app/data/university_model.dart';
import 'package:data_on_app/pages/detail_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<University> searchResults = [];
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  Future<void> searchUniversities(String query) async {
    setState(() {
      searchResults = [];
      isLoading = true;
    });

    try {
      final newResults = await UniversityApi.searchUniversities(query);

      setState(() {
        searchResults = newResults;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search by name',
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      searchUniversities(value);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final university = searchResults[index];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UniversityDetailPage(university: university),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  university.name,
                                  style: blackTextStyle.copyWith(fontSize: 15),
                                ),
                                subtitle: Text(
                                  university.country,
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, color: kGrey),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
