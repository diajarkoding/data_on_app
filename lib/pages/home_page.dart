import 'package:data_on_app/api/api.dart';
import 'package:data_on_app/common/constant.dart';
import 'package:data_on_app/data/university_model.dart';
import 'package:data_on_app/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<University> universities = [];
  int page = 10;
  int pageSize = 10;
  bool isLoading = false;
  bool hasReachedEnd = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchUniversities();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLoading && !hasReachedEnd) {
          page++;
          fetchUniversities();
        }
      }
    });
  }

  Future<void> fetchUniversities() async {
    setState(() {
      isLoading = true;
    });

    try {
      final newUniversities = await UniversityApi.getUniversities(page);

      setState(() {
        universities.addAll(newUniversities);

        if (newUniversities.length < pageSize) {
          hasReachedEnd = true;
        }

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
        title: const Text('Universities'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  ),
              icon: const Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        controller: scrollController,
        itemCount: universities.length + 1,
        itemBuilder: (context, index) {
          if (index < universities.length) {
            final university = universities[index];

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
                        style:
                            blackTextStyle.copyWith(fontSize: 14, color: kGrey),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (!hasReachedEnd) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
