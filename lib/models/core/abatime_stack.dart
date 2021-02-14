import 'package:AbaTime/models/core/abatime_collection.dart';

abstract class AbaTimeStack<T>  {
  
  Future<List<T>> retrieve(String query);
  Future<List<T>> find(String query);
  
}
