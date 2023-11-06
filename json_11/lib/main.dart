import 'dart:async';
import 'dart:convert';
import './pizza.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';
  String convertToJSON (List<Pizza> pizzas) {
    String json = '[';
    for (var pizzas in pizzas) {
      json += jsonEncode(pizzas);
     }
     json += ']';
     return json;
  }

  @override
  void initState() {
    readJsonFile();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON_825210113')),
      body: Container(
        child: FutureBuilder(
          future: readJsonFile(),
          builder: (BuildContext context, AsyncSnapshot <List<Pizza>> pizzas
          ) {
            return ListView.builder(
              itemCount: (pizzas.data == null) ? 0 :
              pizzas.data!.length,
              itemBuilder: (BuildContext context, int position) {
                return ListTile(
                  title: Text(pizzas.data![position].pizzaName),
                  subtitle: Text('${pizzas.data![position].description} - € ${pizzas.data![position].price}'
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
  
  Future<List<Pizza>> readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context).
    loadString('assets/pizzalist.json');
    List myMap = jsonDecode(myString);
    List<Pizza> myPizzas = [];
    for (var pizza in myMap) {
      Pizza myPizza = Pizza.fromJson(pizza);
      myPizzas.add(myPizza);
      
    }
    String json = convertToJSON(myPizzas);
    print(json);
  return myPizzas;
}
}

