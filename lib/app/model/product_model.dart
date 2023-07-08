class ProductModel {
    int? id;
    String? name;
    double? price;
    int? discount;
    String? image;

    ProductModel({
        this.id,
        this.name,
        this.price,
        this.discount,
        this.image,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        discount: json["discount"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "discount": discount,
        "image": image,
    };
}