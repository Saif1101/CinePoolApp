import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppError extends Equatable{
  final AppErrorType appErrorType;
  final String errorMessage;

  AppError({@required this.appErrorType,
    this.errorMessage}):assert(appErrorType!=null);

  @override
  List<Object> get props => [appErrorType];

}

enum AppErrorType {api, network, authentication,database}
