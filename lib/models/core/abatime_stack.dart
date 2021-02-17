abstract class AbaTimeStack<T>  {
  
  Future<List<T>> retrieve(String query);
  Future<List<T>> find(String query);
  
}
