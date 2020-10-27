import 'dart:async';

import 'package:cinema/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class CinemaBloc with Validators {
  final _addressController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();



//Recuperar datos
   Stream<String> get addressStream =>  _addressController.stream; 
   Stream<String> get nameStream => _nameController.stream; 
   Stream<String> get phoneStream => _phoneController.stream;
   Stream<bool> get formValidStream =>    Observable.combineLatest3(addressStream, nameStream ,phoneStream,  (a, b, c) => true);

  //Insertar valores
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  //Obtener ultimos valores ingresados

  String get address => _addressController.value;
  String get name => _nameController.value;
  String get phone => _phoneController.value;

  dispose() {
    _addressController?.close();
    _nameController?.close();
    _phoneController?.close();
  }
}