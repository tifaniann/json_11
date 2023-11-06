import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_11/httphelper.dart';
import 'package:json_11/pizza.dart';
import 'pizza_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = FlutterSecureStorage();
  final myKey = 'myPass';
  final pwdController = TextEditingController();
  String myPass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PizzaDetail()),
            );
          }),
      appBar: AppBar(title: Text('JSON 825210113_delete Web API')),
      body: Container(
        child: FutureBuilder(
          future: callPizzas(),
          builder: (BuildContext context, AsyncSnapshot<List<Pizza>?> pizzas) {
            if (pizzas.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Add a loading indicator
            } else if (pizzas.hasError) {
              return Text('Error: ${pizzas.error}');
            } else {
              return ListView.builder(
                itemCount: (pizzas.data == null) ? 0 : pizzas.data!.length,
                itemBuilder: (BuildContext context, int position) {
                  return Dismissible(
                    onDismissed: (item) {
                      HttpHelper helper = HttpHelper();
                      pizzas.data?.removeWhere(
                          (element) => element.id == pizzas.data![position].id);
                      helper.deletePizza(pizzas.data![position].id);
                    },
                    key: Key(position.toString()),
                    child: ListTile(
                      title: Text(pizzas.data?[position].pizzaName ?? ''),
                      subtitle: Text(
                        '${pizzas.data?[position].description ?? ''} - € ${pizzas.data?[position].price ?? ''}',
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> writeToSecureStorage() async {
    await storage.write(key: myKey, value: pwdController.text);
  }

  Future<String?> readFromSecureStorage() async {
    String? secret = await storage.read(key: myKey);
    return secret ?? '';
  }

  Future<List<Pizza>?> callPizzas() async {
    try {
      HttpHelper helper = HttpHelper();
      List<Pizza>? pizzas = await helper.getPizzaList();
      return pizzas;
    } catch (e) {
      print('Error fetching pizzas: $e');
      return null;
    }
  }
}
