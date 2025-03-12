abstract class FirebaseData<T> {
  T fromFirestore(Map<String, dynamic>? data);
  Map<String, dynamic> toFirestore(T data);
}
