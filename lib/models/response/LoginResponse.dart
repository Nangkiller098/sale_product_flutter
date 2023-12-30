/// id : 15
/// username : "kminchelle"
/// email : "kminchelle@qq.com"
/// firstName : "Jeanne"
/// lastName : "Halvorson"
/// gender : "female"
/// image : "https://robohash.org/autquiaut.png"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvYXV0cXVpYXV0LnBuZyIsImlhdCI6MTcwMzkxNDA0NiwiZXhwIjoxNzAzOTE3NjQ2fQ.JEQJe6HjB6uiQ2RQsPQ5Tq86IoWu6c1VbIUW-VipSA0"

class LoginResponse {
  LoginResponse({
      num id, 
      String username, 
      String email, 
      String firstName, 
      String lastName, 
      String gender, 
      String image, 
      String token,}){
    _id = id;
    _username = username;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _gender = gender;
    _image = image;
    _token = token;
}

  LoginResponse.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _gender = json['gender'];
    _image = json['image'];
    _token = json['token'];
  }
  num _id;
  String _username;
  String _email;
  String _firstName;
  String _lastName;
  String _gender;
  String _image;
  String _token;
LoginResponse copyWith({  num id,
  String username,
  String email,
  String firstName,
  String lastName,
  String gender,
  String image,
  String token,
}) => LoginResponse(  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  gender: gender ?? _gender,
  image: image ?? _image,
  token: token ?? _token,
);
  num get id => _id;
  String get username => _username;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get image => _image;
  String get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['gender'] = _gender;
    map['image'] = _image;
    map['token'] = _token;
    return map;
  }

}