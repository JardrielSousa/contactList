import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void main() {
  runApp(const MyApp());
}


_callNumber() async{
  const number = '085985528894'; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Lista de Contatos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<Contato> contatos = [];

  @override
  void initState() {
    super.initState();
    contatos.add(new Contato("jardriel", "985528894", ContatoType.CASA));
    contatos.add(new Contato("gaby", "982036221", ContatoType.CELULAR));
    contatos.add(new Contato("COGERH", "33618888", ContatoType.TRABALHO));
    contatos.add(new Contato("mae", "95797489", ContatoType.FAVORITO));
    contatos.add(new Contato("pai", "90908888", ContatoType.CELULAR));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Lista de Contatos')
      ),
      body: ListView.separated(itemBuilder: (context , index){
        var contato = contatos[index];
        return ListTile(
          leading: CircleAvatar(
            child: ContatoHelper.getIconByContatoType(contato.tipo),
          ),
          title: Text(contato.nome),
          subtitle: Text(contato.telefone),
          trailing: IconButton(
            icon: Icon(Icons.call),
            onPressed:_callNumber,
          ),
        );
      }, separatorBuilder: (context , index) => Divider(), itemCount: contatos.length),
    );
  }
}

class Contato {
  final String nome;
  final String telefone;
  final ContatoType tipo;

  Contato(this.nome,this.telefone , this.tipo);
}

enum ContatoType { CELULAR , TRABALHO , FAVORITO , CASA}

class ContatoHelper{
  static Icon getIconByContatoType(ContatoType contatoType){
    switch(contatoType){
      case ContatoType.CELULAR:
        return Icon(Icons.phone_android, color: Colors.green[700]);
      case ContatoType.TRABALHO:
        return Icon(Icons.work, color: Colors.brown[600]);
      case ContatoType.FAVORITO:
        return Icon(Icons.star, color: Colors.yellow[600]);
      case ContatoType.CASA:
        return Icon(Icons.home, color: Colors.purple[600]);
    }
  }
}
