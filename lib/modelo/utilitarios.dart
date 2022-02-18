import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'chaves.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:encrypt/encrypt.dart' as cript;
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

String? formatDate(DateTime? dateTime, {mask = "dd/MM/yyyy"}) {
  if (dateTime != null) return DateFormat(mask).format(dateTime);
  return null;
}

String? formatTime(TimeOfDay? time, [bool withSeconds = false]) {
  if (time != null)
    return formatInt(time.hour) +
        ":" +
        formatInt(int.tryParse(time.minute.toString()));
  return null;
}

String? formatDouble(double? n) {
  if (n != null)
    return n
        .toStringAsFixed(n.truncateToDouble() == n ? 0 : 2)
        .replaceAll(".", ",");
  return null;
}

String formatInt(int? n, {int digits = 2}) {
  if (n != null) {
    String mask = "";
    for (int i = 1; i <= digits; i++) mask += "0";
    return NumberFormat(mask).format(n);
  }
  return "";
}

String? decript(String? senha) {
  if (senha != null) {
    var key = cript.Key.fromUtf8(chaveCrypto);
    final iv = cript.IV.fromLength(16);

    final encrypter = cript.Encrypter(cript.AES(key));

    final decrypted = encrypter.decrypt(cript.Encrypted.from64(senha), iv: iv);
    return decrypted.toString();
  } else {
    return null;
  }
}

String? encript(String? senha) {
  if (senha != null) {
    var key = cript.Key.fromUtf8(chaveCrypto);
    final iv = cript.IV.fromLength(16);

    final encrypter = cript.Encrypter(cript.AES(key));

    final encrypted = encrypter.encrypt(senha, iv: iv);
    return encrypted.base64;
  } else {
    return null;
  }
}

String? formataTelefone(String? telefone) {
  if (telefone == null) {
    return null;
  }
  MaskedInputFormatter mascara = MaskedInputFormatter(
      telefone.length == 10 ? '(##)####-####' : '(##)#####-####');
  FormattedValue retorno = mascara.applyMask(telefone);
  return retorno.text;
}

TimeOfDay? stringToTime(String? time) {
  if (time != null) {
    List timeParts = time.split(":");
    return TimeOfDay(
        hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
  }
  return null;
}

/**
 * Para utilização desta função, segue uma condição como eemplo
 * 
 *  if (!await launch(geraLinkURL('-24.7367379','-53.7408717'))) throw 'Não foi possivel acessar o link';
 * 
 */

geraLinkURL(String parametroOne, String parametroTwo) {
  if (parametroOne.isEmpty == false && parametroTwo.isEmpty == false) {
    String urlMaps =
        'https://www.google.com/maps/dir/?api=1&saddr=My+Location&destination=${parametroOne}%2C${parametroTwo}&travelmode=car';

    launch(urlMaps);
  } else {
    parametroOne.length > 10
        ? parametroOne
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('-', '')
        : parametroOne = parametroOne;
    String urlWhats = 'https://api.whatsapp.com/send?phone=+55${parametroOne}';
    launch(urlWhats);
  }
}

/**
 * Método responsavel para fazer a formatação de documento
 * CNPJ tira pontos e adiciona pontos
 * o valor actio deve ser utilizado da seguinte forma:
 *      1 - REMOVER PONTUAÇÃO CNPJ
 *      2 - ADICIONAR PONTUAÇÃO CNPJ
 */
String documentformater(String documento, int action) {
  switch (action) {
    case 1:
      documento =
          documento.replaceAll('.', '').replaceAll('-', '').replaceAll('/', '');
      break;
    case 2:
      String acm = '';
      for (int i = 0; i < documento.length; i++) {
        if (i == 2 || i == 5) {
          acm += '.' + documento[i];
        } else if (i == 8) {
          acm += '/' + documento[i];
        } else if (i == 12) {
          acm += '-' + documento[i];
        } else {
          acm += documento[i];
        }
      }
      documento = acm;
      break;
    default:
  }

  return documento;
}

/* Exemplo de USO
  enviarEmail(
      destinatarios: ['seuemail@teste.com'],
      assunto: 'Tente de e-mail',
      emailRemetente: 'emailreposta@gmail.com',
      nomeRemetente: 'Seu nome',
      texto: 'Este é o corpo de um e-mail de testes. Se você recebeu este e-mail, deu tudo certo!');
*/
Future<bool> enviarEmail({
  List<String> destinatarios = const [],
  String assunto = '',
  String texto = '',
  String nomeRemetente = '',
  String emailRemetente = '',
}) async {
  String requestBody = '''{  
            "sender":{  
                "name":"$nomeRemetente",
                "email":"$emailRemetente"
            },
            "to":[''';

  for (String enderecoDestinatario in destinatarios) {
    requestBody += '''{  
                  "email":"$enderecoDestinatario",
                  "name":"$nomeRemetente"
                }''';
  }
  requestBody += '''],
            "subject":"$assunto",
            "htmlContent":"${!texto.contains("<html>") ? '<html>' + texto.replaceAll('\n', '').replaceAll('"', "'") + '</html>' : texto.replaceAll('\n', '').replaceAll('"', "'")}"
          }''';
  Response response =
      await post(Uri.parse('https://api.sendinblue.com/v3/smtp/email'),
          headers: <String, String>{
            'accept': 'application/json',
            'api-key': chaveAPIEmail,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: requestBody);

  return response.statusCode == 201;
}

Future<LocationData?> getCurrentLocation() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();
  return _locationData;
}

String generateUniqueID() {
  return Uuid().v4();
}
