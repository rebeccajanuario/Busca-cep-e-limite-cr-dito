import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _cep = TextEditingController();
  String _RESULT = "0";
  String _logradouro = "";
  TextEditingController _complemento = TextEditingController();
  TextEditingController _numero = TextEditingController();
  String _bairro = "";
  String _localidade = "";
  String _uf = "";
  String _limite = "";
  TextEditingController _renda = TextEditingController();

  _enderecoCompleto() async {
    String urlAPI = "https://viacep.com.br/ws/" +
        (int.tryParse(_cep.text)).toString() +
        "/json/";
    http.Response response;
    response = await http.get(urlAPI);
    Map<String, dynamic> retorno = json.decode(response.body);
    print(retorno);
    setState(() {
      _logradouro = retorno["logradouro"].toString();
      _bairro = retorno["bairro"].toString();
      _localidade = retorno["localidade"].toString();
      _uf = retorno["uf"].toString();
    });
  }

  void _limiteCredito() {
    setState(() {
      _limite = "Seu limite baseado no seu salário é: " +
          (double.parse(_renda.text) * 0.3).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(child: Text("APP Cep e Salário")),
            backgroundColor: Colors.indigo.shade900,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.app_shortcut_outlined),
                tooltip: 'Procurar endereço',
                onPressed: _enderecoCompleto,
              )
            ]),
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_location_outlined,
                    size: 100.0, color: Colors.blueGrey.shade800),
                Column(children: <Widget>[
                  Text(" "),
                  TextField(
                      decoration: InputDecoration(
                        labelText: "Digite seu CEP",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                      controller: _cep),
                ]),
                Container(
                    margin: (EdgeInsets.only(top: 20, left: 25, right: 25)),
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade900,
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    child: TextButton(
                        child: Center(
                          child: Text(
                            "Buscar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: _enderecoCompleto)),
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "Logradouro: " + _logradouro.toString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: TextField(
                        controller: _complemento,
                        decoration: InputDecoration(
                          labelText: "Insira o complemento",
                        ))),
                Container(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: TextField(
                        controller: _numero,
                        decoration: InputDecoration(
                          labelText: "Insira o número",
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "Bairro: " + _bairro.toString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "Localidade: " + _localidade.toString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "UF: " + _uf.toString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Icon(Icons.attach_money,
                    size: 100.0, color: Colors.blueGrey.shade800),
                Column(children: <Widget>[
                  Text(" "),
                  TextField(
                      decoration: InputDecoration(
                        labelText:
                            "Digite sua renda mensal para calculo do crédito:",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                      controller: _renda),
                ]),
                Container(
                    margin: (EdgeInsets.only(top: 20, left: 25, right: 25)),
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade900,
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    child: TextButton(
                        child: Center(
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: _limiteCredito)),
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text(
                      "" + _limite.toString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
              ],
            ),
          ),
        )));
  }
}
