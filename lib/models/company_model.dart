class Company{
  String? logo;
  String? name;

  Company({this.logo, this.name});

  factory Company.fromJson(Map<String,dynamic> data){
    return  Company(
        logo: data["logo_path"]??"",
        name: data["name"]??"",
    );
  }
}