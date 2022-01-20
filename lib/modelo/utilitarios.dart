import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organicos/controle/controle_sistema.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'chaves.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

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

String? generateSignature(String? senha) {
  if (senha != null) {
    var encodedKey = utf8.encode(chaveCrypto);
    var hmacSha512 = new Hmac(sha512, encodedKey);
    var bytesDataIn = utf8.encode(senha);
    var digest = sha512.convert(bytesDataIn);
    String singedValue = digest.toString();
    return singedValue;
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

/**
 * Para utilização desta função, segue uma condição como eemplo
 * 
 *  if (!await launch(geraLinkURL('-24.7367379','-53.7408717'))) throw 'Não foi possivel acessar o link';
 * 
 */

String geraLinkURL(String parametroOne, String parametroTwo) {
  if (parametroOne.isEmpty == false && parametroTwo.isEmpty == false) {
    String urlMaps ='https://www.google.com/maps/dir/?api=1&saddr=My+Location&destination=${parametroOne}%2C${parametroTwo}&travelmode=car';
         
    return urlMaps;
  } else {
    parametroOne.length > 10
        ? parametroOne
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('-', '')
        : parametroOne = parametroOne;
    String urlWhats = 'https://api.whatsapp.com/send?phone=+55${parametroOne}';
   
    return urlWhats;
  }
}
