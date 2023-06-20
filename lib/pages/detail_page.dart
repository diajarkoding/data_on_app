import 'package:data_on_app/common/constant.dart';
import 'package:data_on_app/data/university_model.dart';
import 'package:flutter/material.dart';

class UniversityDetailPage extends StatelessWidget {
  final University university;

  const UniversityDetailPage({Key? key, required this.university})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(university.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Country: ${university.country}',
              style: blackTextStyle.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Alpha Two Code: ${university.alphaTwoCode}',
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'State/Province: ${university.stateProvince ?? "N/A"}',
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Domains:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: university.domains.map((domain) {
                return Text(
                  domain,
                  style: blackTextStyle.copyWith(fontSize: 16),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Web Pages:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              children: university.webPages.map((webPage) {
                return Text(
                  webPage,
                  style: blackTextStyle.copyWith(fontSize: 16),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
