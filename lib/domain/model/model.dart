class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer{
  String id;
  String name;
  int numOfNotification;

  Customer(this.id, this.name, this.numOfNotification);
}

class Contacts{
  String email;
  String phone;
  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication{
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}



class DeviceInfo{
  String name;
  String Identifier;
  String version;

  DeviceInfo(this.name, this.Identifier, this.version);
}

class Services{
  int id;
  String title;
  String image;

  Services(this.id, this.title, this.image);
}

class Store{
  int id;
  String title;
  String image;


  Store(this.id, this.title, this.image );
}

class Banners{
  int id;
  String title;
  String image;
  String link;
  Banners(this.id, this.title, this.image, this.link);
}

class HomeData{
  List<Services> services;
  List<Store> store;
  List<Banners> banner;

  HomeData(this.services, this.store, this.banner);
}

class HomeObject{
  HomeData data;

  HomeObject(this.data);
}



