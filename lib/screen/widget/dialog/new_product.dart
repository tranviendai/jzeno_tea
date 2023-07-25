import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_state.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:dotted_border/dotted_border.dart';

class AlertProduct extends StatefulWidget {
  final String? title;
  final ProductModel? product;
  const AlertProduct({super.key, this.product, this.title});

  @override
  State<AlertProduct> createState() => _AlertProductState();
}

class _AlertProductState extends State<AlertProduct> {
  TextEditingController nameProduct = TextEditingController();
  TextEditingController priceProduct = TextEditingController();
  TextEditingController materialProduct = TextEditingController();
  TextEditingController discountProduct = TextEditingController();
  TextEditingController descriptionProduct = TextEditingController();
  TextEditingController categoryProduct = TextEditingController();
  TextEditingController colorProduct = TextEditingController();

  String pathImage =
      "C:\\Users\\JZeno\\OneDrive - Ho Chi Minh City University of Foreign Languages and Information Technology - HUFLIT\\Desktop\\JZTea\\images\\";
  List<String>? colors = [];
  List<PlatformFile>? _imageFile = [];
  String selectCategory = "";
  int indexTextController = 0;
  ProductModel product = ProductModel();
  @override
  void initState() {
    if (widget.product != null) {
      nameProduct.text = widget.product!.name.toString();
      priceProduct.text = widget.product!.price.toString();
      discountProduct.text = widget.product!.discount.toString();
      descriptionProduct.text = widget.product!.description.toString();
      selectCategory = widget.product!.categoryID!;
      product = widget.product!;
      PlatformFile imageFile = PlatformFile(
          name: widget.product!.image!,
          path: pathImage + widget.product!.image!,
          size: 1);
      _imageFile!.add(imageFile);
    } else {
      selectCategory = "milk tea";
    }
    super.initState();
  }

  @override
  void dispose() {
    nameProduct.dispose();
    priceProduct.dispose();
    materialProduct.dispose();
    discountProduct.dispose();
    descriptionProduct.dispose();
    categoryProduct.dispose();
    colorProduct.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.any, withData: true);
      if (result == null) return;
      setState(() {
        _imageFile = result.files;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Widget uploadImage() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(children: [
        InkWell(
          onTap: () {
            _pickImage();
          },
          child: DottedBorder(
            color: Colors.blueAccent,
            strokeWidth: 2,
            dashPattern: const [5, 5],
            child: Container(
              height: 75,
              width: 75,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  AppText.addImageText,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        if (_imageFile != null)
          SizedBox(
            height: 100,
            width: 410,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imageFile!.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.file(
                      File(_imageFile![index].path!),
                      width: 75,
                      height: 75,
                      fit: BoxFit.fitWidth,
                    ));
              },
            ),
          )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      bloc: ProductCubit(),
      builder: (context, state) => AlertDialog(
        title: Text(widget.title!),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              children: [
                uploadImage(),
                loadListCategory(),
                AppText.textFiled(
                    context, nameProduct, AppText.nameText, Icons.abc),
                AppText.textFiled(
                    context, priceProduct, AppText.priceText, Icons.numbers),
                AppText.textFiled(context, discountProduct,
                    AppText.discountText, Icons.numbers),
                AppText.textFiled(context, descriptionProduct,
                    AppText.descriptionText, Icons.abc),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              if (widget.title == AppText.newProductText) {
                if (_imageFile!.isEmpty ||
                    nameProduct.text.isEmpty ||
                    priceProduct.text.isEmpty ||
                    discountProduct.text.isEmpty ||
                    descriptionProduct.text.isEmpty ||
                    int.tryParse(discountProduct.text)! > 99) {
                  showDialogError();
                } else {
                  product.image = _imageFile!.first.name;
                  product.name = nameProduct.text;
                  product.price = double.tryParse(priceProduct.text);
                  product.discount = int.tryParse(discountProduct.text);
                  product.description = descriptionProduct.text;
                  product.categoryID = selectCategory;
                  context.read<ProductCubit>().addProduct(product);
                  Navigator.of(context).popAndPushNamed("/");
                }
              } else {
                product.name = nameProduct.text;
                product.price = double.tryParse(priceProduct.text);
                product.discount = int.tryParse(discountProduct.text);
                product.description = descriptionProduct.text;
                product.image = _imageFile!.first.name;
                product.categoryID = selectCategory;
                context
                    .read<ProductCubit>()
                    .updateProduct(product.id!, product);
                Navigator.of(context).popAndPushNamed("/");
              }
            },
            child: widget.product != null
                ? const Text('UPDATE')
                : const Text('ACCEPT'),
          ),
        ],
      ),
    );
  }

  Widget loadListCategory() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoaded) {
          return DropdownButtonFormField(
            value: state.categories.last,
            items: state.categories
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e.id.toString())))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectCategory = value!.id!;
              });
            },
            dropdownColor: Colors.blue.shade50,
            decoration: InputDecoration(
                labelText: AppText.categoryText,
                prefixIcon: const Icon(
                  Icons.abc,
                  color: Colors.blue,
                )),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future showDialogError() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Please enter data"),
            title: const Text("Error"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }
}
