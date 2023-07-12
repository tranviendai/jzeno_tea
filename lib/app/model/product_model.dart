import 'package:jzeno_tea/app/model/topping_model.dart';

class ProductModel {
    int? id;
    String? name;
    double? price;
    int? discount;
    String? image;
    String? description;
    String? postDate;
    bool? isPublic;
    String? size;
    int? quantity;
    List<ToppingModel>? topping;

    ProductModel({
        this.id,
        this.name,
        this.price,
        this.discount,
        this.image,
        this.description,
        this.postDate,
        this.isPublic,
        this.size,
        this.quantity,
        this.topping
    });

    factory ProductModel.fromListJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        discount: json["discount"],
        image: json["image"],
        description : json["description"],
        postDate: json["postDate"],
        isPublic: json["isPublic"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "discount": discount,
        "image": image,
        "description": description,
        "postDate": postDate,
        "isPublic": isPublic
    };

     double get totalPrice => topping!.fold(0, (total, current) => total + current.price!);

}