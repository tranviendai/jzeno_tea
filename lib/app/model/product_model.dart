class ProductModel {
    int? id;
    String? name;
    double? price;
    String? color;
    String? description;
    String? postDate;
    String? image;
    String? category;

    ProductModel({
        this.id,
        this.name,
        this.price,
        this.color,
        this.description,
        this.postDate,
        this.image,
        this.category,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        color: json["color"],
        description: json["description"],
        postDate: json["postDate"],
        image: json["image"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "color": color,
        "description": description,
        "postDate": postDate,
        "image": image,
        "category": category,
    };
}
