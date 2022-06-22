import 'package:equatable/equatable.dart';

/// results : [{"gender":"female","name":{"title":"Ms","first":"Elizabeth","last":"Williams"},"location":{"street":{"number":6271,"name":"Universal Drive"},"city":"Whangarei","state":"Bay of Plenty","country":"New Zealand","postcode":99230,"coordinates":{"latitude":"66.5709","longitude":"155.8588"},"timezone":{"offset":"-9:00","description":"Alaska"}},"email":"elizabeth.williams@example.com","login":{"uuid":"3eb1aef1-ffe2-47da-b8a4-8cd4ec09a76b","username":"crazylion804","password":"music","salt":"06iDZNoG","md5":"9b825b930e14974239396f495ae38c8d","sha1":"f4dab29d4c9e37f54c722c692dfc36a4a4ff73de","sha256":"8304b16cad73a6166dd252f6e197e0e5ae38c4a87ad63f40777639454ed8953b"},"dob":{"date":"1989-07-31T14:43:21.195Z","age":33},"registered":{"date":"2006-10-09T13:56:31.389Z","age":16},"phone":"(706)-643-7090","cell":"(830)-576-5033","id":{"name":"","value":null},"picture":{"large":"https://randomuser.me/api/portraits/women/90.jpg","medium":"https://randomuser.me/api/portraits/med/women/90.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/women/90.jpg"},"nat":"NZ"}]
/// info : {"seed":"9ca3f4381a64473f","results":1,"page":1,"version":"1.3"}

class RandomApiModel {
  RandomApiModel({
      List<Results>? results, 
      Info? info,}){
    _results = results;
    _info = info;
}

  RandomApiModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
    _info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }
  List<Results>? _results;
  Info? _info;
  List<Results>? get results => _results;
  Info? get info => _info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    if (_info != null) {
      map['info'] = _info?.toJson();
    }
    return map;
  }

}

/// seed : "9ca3f4381a64473f"
/// results : 1
/// page : 1
/// version : "1.3"

class Info {
  Info({
      String? seed, 
      int? results, 
      int? page, 
      String? version,}){
    _seed = seed;
    _results = results;
    _page = page;
    _version = version;
}

  Info.fromJson(dynamic json) {
    _seed = json['seed'];
    _results = json['results'];
    _page = json['page'];
    _version = json['version'];
  }
  String? _seed;
  int? _results;
  int? _page;
  String? _version;
  String? get seed => _seed;
  int? get results => _results;
  int? get page => _page;
  String? get version => _version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seed'] = _seed;
    map['results'] = _results;
    map['page'] = _page;
    map['version'] = _version;
    return map;
  }

}

/// gender : "female"
/// name : {"title":"Ms","first":"Elizabeth","last":"Williams"}
/// location : {"street":{"number":6271,"name":"Universal Drive"},"city":"Whangarei","state":"Bay of Plenty","country":"New Zealand","postcode":99230,"coordinates":{"latitude":"66.5709","longitude":"155.8588"},"timezone":{"offset":"-9:00","description":"Alaska"}}
/// email : "elizabeth.williams@example.com"
/// login : {"uuid":"3eb1aef1-ffe2-47da-b8a4-8cd4ec09a76b","username":"crazylion804","password":"music","salt":"06iDZNoG","md5":"9b825b930e14974239396f495ae38c8d","sha1":"f4dab29d4c9e37f54c722c692dfc36a4a4ff73de","sha256":"8304b16cad73a6166dd252f6e197e0e5ae38c4a87ad63f40777639454ed8953b"}
/// dob : {"date":"1989-07-31T14:43:21.195Z","age":33}
/// registered : {"date":"2006-10-09T13:56:31.389Z","age":16}
/// phone : "(706)-643-7090"
/// cell : "(830)-576-5033"
/// id : {"name":"","value":null}
/// picture : {"large":"https://randomuser.me/api/portraits/women/90.jpg","medium":"https://randomuser.me/api/portraits/med/women/90.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/women/90.jpg"}
/// nat : "NZ"

class Results extends Equatable {
  Results({
      String? gender, 
      Name? name, 
      Location? location, 
      String? email, 
      Login? login, 
      Dob? dob, 
      Registered? registered, 
      String? phone, 
      String? cell, 
      Id? id, 
      Picture? picture, 
      String? nat,}){
    _gender = gender;
    _name = name;
    _location = location;
    _email = email;
    _login = login;
    _dob = dob;
    _registered = registered;
    _phone = phone;
    _cell = cell;
    _id = id;
    _picture = picture;
    _nat = nat;
}

  Results.fromJson(dynamic json) {
    _gender = json['gender'];
    _name = json['name'] != null ? Name.fromJson(json['name']) : null;
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _email = json['email'];
    _login = json['login'] != null ? Login.fromJson(json['login']) : null;
    _dob = json['dob'] != null ? Dob.fromJson(json['dob']) : null;
    _registered = json['registered'] != null ? Registered.fromJson(json['registered']) : null;
    _phone = json['phone'];
    _cell = json['cell'];
    _id = json['id'] != null ? Id.fromJson(json['id']) : null;
    _picture = json['picture'] != null ? Picture.fromJson(json['picture']) : null;
    _nat = json['nat'];
  }
  String? _gender;
  Name? _name;
  Location? _location;
  String? _email;
  Login? _login;
  Dob? _dob;
  Registered? _registered;
  String? _phone;
  String? _cell;
  Id? _id;
  Picture? _picture;
  String? _nat;
  String? get gender => _gender;
  Name? get name => _name;
  Location? get location => _location;
  String? get email => _email;
  Login? get login => _login;
  Dob? get dob => _dob;
  Registered? get registered => _registered;
  String? get phone => _phone;
  String? get cell => _cell;
  Id? get id => _id;
  Picture? get picture => _picture;
  String? get nat => _nat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gender'] = _gender;
    if (_name != null) {
      map['name'] = _name?.toJson();
    }
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['email'] = _email;
    if (_login != null) {
      map['login'] = _login?.toJson();
    }
    if (_dob != null) {
      map['dob'] = _dob?.toJson();
    }
    if (_registered != null) {
      map['registered'] = _registered?.toJson();
    }
    map['phone'] = _phone;
    map['cell'] = _cell;
    if (_id != null) {
      map['id'] = _id?.toJson();
    }
    if (_picture != null) {
      map['picture'] = _picture?.toJson();
    }
    map['nat'] = _nat;
    return map;
  }

  @override
  List<Object?> get props => [name, gender, location, email, login, dob, registered, phone, cell, id, picture, nat];
}

/// large : "https://randomuser.me/api/portraits/women/90.jpg"
/// medium : "https://randomuser.me/api/portraits/med/women/90.jpg"
/// thumbnail : "https://randomuser.me/api/portraits/thumb/women/90.jpg"

class Picture extends Equatable {
  Picture({
      String? large, 
      String? medium, 
      String? thumbnail,}){
    _large = large;
    _medium = medium;
    _thumbnail = thumbnail;
}

  Picture.fromJson(dynamic json) {
    _large = json['large'];
    _medium = json['medium'];
    _thumbnail = json['thumbnail'];
  }
  String? _large;
  String? _medium;
  String? _thumbnail;
  String? get large => _large;
  String? get medium => _medium;
  String? get thumbnail => _thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['large'] = _large;
    map['medium'] = _medium;
    map['thumbnail'] = _thumbnail;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [large, medium, thumbnail];

}

/// name : ""
/// value : null

class Id extends Equatable {
  Id({
      String? name, 
      dynamic value,}){
    _name = name;
    _value = value;
}

  Id.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'];
  }
  String? _name;
  dynamic _value;
  String? get name => _name;
  dynamic get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, value];

}

/// date : "2006-10-09T13:56:31.389Z"
/// age : 16

class Registered extends Equatable {
  Registered({
      String? date, 
      int? age,}){
    _date = date;
    _age = age;
}

  Registered.fromJson(dynamic json) {
    _date = json['date'];
    _age = json['age'];
  }
  String? _date;
  int? _age;
  String? get date => _date;
  int? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['age'] = _age;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [date, age];

}

/// date : "1989-07-31T14:43:21.195Z"
/// age : 33

class Dob extends Equatable {
  Dob({
      String? date, 
      int? age,}){
    _date = date;
    _age = age;
}

  Dob.fromJson(dynamic json) {
    _date = json['date'];
    _age = json['age'];
  }
  String? _date;
  int? _age;
  String? get date => _date;
  int? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['age'] = _age;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [date, age];

}

/// uuid : "3eb1aef1-ffe2-47da-b8a4-8cd4ec09a76b"
/// username : "crazylion804"
/// password : "music"
/// salt : "06iDZNoG"
/// md5 : "9b825b930e14974239396f495ae38c8d"
/// sha1 : "f4dab29d4c9e37f54c722c692dfc36a4a4ff73de"
/// sha256 : "8304b16cad73a6166dd252f6e197e0e5ae38c4a87ad63f40777639454ed8953b"

class Login extends Equatable {
  Login({
      String? uuid, 
      String? username, 
      String? password, 
      String? salt, 
      String? md5, 
      String? sha1, 
      String? sha256,}){
    _uuid = uuid;
    _username = username;
    _password = password;
    _salt = salt;
    _md5 = md5;
    _sha1 = sha1;
    _sha256 = sha256;
}

  Login.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _username = json['username'];
    _password = json['password'];
    _salt = json['salt'];
    _md5 = json['md5'];
    _sha1 = json['sha1'];
    _sha256 = json['sha256'];
  }
  String? _uuid;
  String? _username;
  String? _password;
  String? _salt;
  String? _md5;
  String? _sha1;
  String? _sha256;
  String? get uuid => _uuid;
  String? get username => _username;
  String? get password => _password;
  String? get salt => _salt;
  String? get md5 => _md5;
  String? get sha1 => _sha1;
  String? get sha256 => _sha256;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['username'] = _username;
    map['password'] = _password;
    map['salt'] = _salt;
    map['md5'] = _md5;
    map['sha1'] = _sha1;
    map['sha256'] = _sha256;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uuid, username, password, salt, md5, sha1, sha256];
}

/// street : {"number":6271,"name":"Universal Drive"}
/// city : "Whangarei"
/// state : "Bay of Plenty"
/// country : "New Zealand"
/// postcode : 99230
/// coordinates : {"latitude":"66.5709","longitude":"155.8588"}
/// timezone : {"offset":"-9:00","description":"Alaska"}

class Location extends Equatable {
  Location({
      Street? street, 
      String? city, 
      String? state, 
      String? country,
      dynamic postcode,
      Coordinates? coordinates, 
      Timezone? timezone,}){
    _street = street;
    _city = city;
    _state = state;
    _country = country;
    _postcode = postcode;
    _coordinates = coordinates;
    _timezone = timezone;
}

  Location.fromJson(dynamic json) {
    _street = json['street'] != null ? Street.fromJson(json['street']) : null;
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _postcode = json['postcode'];
    _coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
    _timezone = json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null;
  }
  Street? _street;
  String? _city;
  String? _state;
  String? _country;
  dynamic _postcode;
  Coordinates? _coordinates;
  Timezone? _timezone;
  Street? get street => _street;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  dynamic get postcode => _postcode;
  Coordinates? get coordinates => _coordinates;
  Timezone? get timezone => _timezone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_street != null) {
      map['street'] = _street?.toJson();
    }
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['postcode'] = _postcode;
    if (_coordinates != null) {
      map['coordinates'] = _coordinates?.toJson();
    }
    if (_timezone != null) {
      map['timezone'] = _timezone?.toJson();
    }
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [street, city, state, country, postcode, coordinates, timezone];

}

/// offset : "-9:00"
/// description : "Alaska"

class Timezone extends Equatable {
  Timezone({
      String? offset, 
      String? description,}){
    _offset = offset;
    _description = description;
}

  Timezone.fromJson(dynamic json) {
    _offset = json['offset'];
    _description = json['description'];
  }
  String? _offset;
  String? _description;
  String? get offset => _offset;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = _offset;
    map['description'] = _description;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [offset, description];

}

/// latitude : "66.5709"
/// longitude : "155.8588"

class Coordinates extends Equatable {
  Coordinates({
      String? latitude, 
      String? longitude,}){
    _latitude = latitude;
    _longitude = longitude;
}

  Coordinates.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  String? _latitude;
  String? _longitude;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [latitude, longitude];

}

/// number : 6271
/// name : "Universal Drive"

class Street extends Equatable {
  Street({
      int? number, 
      String? name,}){
    _number = number;
    _name = name;
}

  Street.fromJson(dynamic json) {
    _number = json['number'];
    _name = json['name'];
  }
  int? _number;
  String? _name;
  int? get number => _number;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = _number;
    map['name'] = _name;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [number, name];

}

/// title : "Ms"
/// first : "Elizabeth"
/// last : "Williams"

class Name extends Equatable {
  Name({
      String? title, 
      String? first, 
      String? last,}){
    _title = title;
    _first = first;
    _last = last;
}

  Name.fromJson(dynamic json) {
    _title = json['title'];
    _first = json['first'];
    _last = json['last'];
  }
  String? _title;
  String? _first;
  String? _last;
  String? get title => _title;
  String? get first => _first;
  String? get last => _last;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['first'] = _first;
    map['last'] = _last;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title, first, last];

}