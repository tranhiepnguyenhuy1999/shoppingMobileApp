import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    Key? key,
  }) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String base64Image = "";
  Uint8List? data;
  final _textController = TextEditingController();
  bool _textValidate = false;

  final _productNameTextController = TextEditingController();
  bool _productNameValidate = false;

  final _originTextController = TextEditingController();
  bool _originValidate = false;

  final _sizeTextController = TextEditingController();
  bool _sizeValidate = false;

  final _priceTextController = TextEditingController();
  bool _priceValidate = false;

  final _addressTextController = TextEditingController();
  bool _addressValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    /// Get from camera
    _getFromCamera() async {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 25,
          preferredCameraDevice: CameraDevice.front);

      if (image != null) {
        final bytes = File(image.path).readAsBytesSync();
        setState(() {
          base64Image = base64Encode(bytes);
        });
      }
      print(base64Image);
      setState(() {
        data = base64.decode(base64Image);
      });
    }

    closeKeyboard(BuildContext context) {
      var currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 47.5, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0.5, 0, 5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_outlined),
                                        color: Colors.white,
                                        iconSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              child: Column(
                                children: const [
                                  Text(
                                    "Thêm sản phẩm ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: SizedBox(
                      width: width,
                      height: height / 1.35,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  controller: _productNameTextController,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: "Tên sản phẩm",
                                    errorText: _productNameValidate
                                        ? 'Vui lòng nhập tên '
                                        : null,
                                    labelStyle: const TextStyle(
                                        color: Color(0xff888888), fontSize: 14),
                                  ),
                                  onEditingComplete: () {
                                    setState(() {
                                      _productNameTextController.text.isEmpty
                                          ? _productNameValidate = true
                                          : _productNameValidate = false;
                                    });
                                    if (_productNameValidate != true) {
                                      closeKeyboard(context);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  controller: _originTextController,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: "Xuất xứ",
                                    errorText: _originValidate
                                        ? 'Vui lòng nhập xuất xứ '
                                        : null,
                                    labelStyle: const TextStyle(
                                        color: Color(0xff888888), fontSize: 14),
                                  ),
                                  onEditingComplete: () {
                                    setState(() {
                                      _originTextController.text.isEmpty
                                          ? _originValidate = true
                                          : _originValidate = false;
                                    });
                                    if (_originValidate != true) {
                                      closeKeyboard(context);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  controller: _sizeTextController,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: "Kích thước",
                                    errorText: _sizeValidate
                                        ? 'Vui lòng nhập kích thước'
                                        : null,
                                    labelStyle: const TextStyle(
                                        color: Color(0xff888888), fontSize: 14),
                                  ),
                                  onEditingComplete: () {
                                    setState(() {
                                      _sizeTextController.text.isEmpty
                                          ? _sizeValidate = true
                                          : _sizeValidate = false;
                                    });
                                    if (_sizeValidate != true) {
                                      closeKeyboard(context);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 250.0,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        onSubmitted: (v) {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        controller: _priceTextController,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                        decoration: InputDecoration(
                                          labelText: "Giá",
                                          errorText: _priceValidate
                                              ? 'Vui lòng nhập giá'
                                              : null,
                                          labelStyle: const TextStyle(
                                              color: Color(0xff888888),
                                              fontSize: 14),
                                        ),
                                        onEditingComplete: () {
                                          setState(() {
                                            _priceTextController.text.isEmpty
                                                ? _priceValidate = true
                                                : _priceValidate = false;
                                          });
                                          if (_priceValidate != true) {
                                            closeKeyboard(context);
                                          }
                                        },
                                      ),
                                    ),
                                    Text("USDT")
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    FocusScope.of(context).nextFocus();
                                  },
                                  controller: _addressTextController,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: "Địa chỉ",
                                    errorText: _addressValidate
                                        ? 'Vui lòng nhập địa chỉ'
                                        : null,
                                    labelStyle: const TextStyle(
                                        color: Color(0xff888888), fontSize: 14),
                                  ),
                                  onEditingComplete: () {
                                    setState(() {
                                      _addressTextController.text.isEmpty
                                          ? _addressValidate = true
                                          : _addressValidate = false;
                                    });
                                    if (_addressValidate != true) {
                                      closeKeyboard(context);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nhập mô tả :  ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width - 30,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.3),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _textController,
                                      // obscureText: true,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            _textValidate = false;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        errorText: _textValidate
                                            ? 'Vui lòng nhập nội dung'
                                            : null,
                                        contentPadding: EdgeInsets.all(20.0),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        hintText: 'Thêm mô tả ...',
                                      ),
                                      minLines: 11,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                                icon: Icon(Icons.add_a_photo_outlined),
                                onPressed: () {
                                  _getFromCamera();
                                },
                                label: Text(
                                  "Thêm ảnh",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Ảnh đã thêm: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    data != null && data!.isNotEmpty
                                        ? IconButton(
                                            icon: Image.memory(
                                              data!,
                                            ),
                                            iconSize: 115,
                                            onPressed: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                content: Image.memory(
                                                  data!,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    TextButton(
                                        child: data != null && data!.isNotEmpty
                                            ? Text("Xóa")
                                            : Text(""),
                                        onPressed: () {
                                          if (data != null) {
                                            setState(() {
                                              data = null;
                                            });
                                          }
                                        })
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            title: const Text(
                                'Bạn có muốn đăng bán sản phẩm này ?'),
                            // content: Image.asset(
                            //   'assets/images/icons/tick.png',
                            //   height: 75,
                            //   width: 75,
                            // ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {},
                                child: const Text(
                                  'Đồng ý',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Huỷ bỏ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        "Tạo sản phẩm",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8));
                          }),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff1BB05B))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
