import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task5_adv/models/persons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var persons = ValueNotifier<List<Persons>>([]);
  var isLoading = ValueNotifier<bool>(false);
  @override
  void initState() {
    initPersons();
    super.initState();
  }

  void initPersons() async {
    isLoading.value = true;
    try {
      var result = await rootBundle.loadString('assets/data.json');
      var response = jsonDecode(result);
      if (response['success']) {
        var loadedPersons =
            (response['data'] as List).map((e) => Persons.fromJson(e)).toList();
        persons.value = loadedPersons;
        isLoading.value = false;
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    persons.dispose();
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List'),
      ),
      body: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (context, loading, child) {
            if (loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ValueListenableBuilder(
                  valueListenable: persons,
                  builder: (context, persons, child) {
                    return ListView(
                      children: persons
                          .map((e) => ListTile(
                                leading: CircleAvatar(
                                  child: Image.asset(
                                    'profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(e.name),
                                subtitle: Text('Age: ${e.age.toString()}'),
                              ))
                          .toList(),
                    );
                  });
            }
          }),
    );
  }
}
