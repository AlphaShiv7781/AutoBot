
import 'package:flutter/material.dart';

import '../models/model.dart';
import '../services/api_service.dart';

class ModelsProvider with ChangeNotifier {

  String currentModel = "davinci";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {

    currentModel=newModel;
    notifyListeners();
  }


  List<ModelsModel> modelsList = [];
  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModel() async{

    modelsList =await ApiServices.getModels();
    return modelsList;
  }
}
