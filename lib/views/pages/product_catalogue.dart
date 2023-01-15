import 'package:ebusiness_atk_mobile/views/components/custom_product_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/auth_condition/auth_condition_bloc.dart';
import '../../bloc/catalogue/catalogue_bloc.dart';
import '../components/preset_snackbar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCataloguePage extends StatefulWidget {
  const ProductCataloguePage({Key? key}) : super(key: key);

  @override
  State<ProductCataloguePage> createState() => _ProductCataloguePageState();
}

class _ProductCataloguePageState extends State<ProductCataloguePage> with TickerProviderStateMixin {
  // final int total_produk = await FirebaseFirestore.instance.collection('products').snapshots().length;
  // final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance.collection('produk_atk').snapshots();

  String globalNamaProduk = "";
  String globalKategoriProduk = "dummy init";
  String globalFotoProduk = "";
  int globalIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple[300],
              centerTitle: true,
              title: Text("Beli ATK"),
              actions: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: _showAppBarDropdownMenu,
                )
              ],
            ),
            body: BlocListener<AuthConditionBloc, AuthConditionState>(
              listener: (context, state) {
                if (state is AuthSuccess) PresetSnackbar(color: Colors.green, context: context, message: "Anda berhasil login");
              },
              child: BlocBuilder<CatalogueBloc, CatalogueInitial>(
                builder: (context, state) {
                  return CustomProductView(
                    isGridView: true,
                    listofProducts: state.listofProductData,
                    maxColumn: state.maxColumn,
                    maxRow: state.maxRow
                  );
                }
              ),
            )
            // body: Stack(
            //   children: [
            //     // CustomProductTile()
            //     CustomGridView(1,)
            //     // _sliver(),
            //     // _blackScreen(visible: _isBlackScreenVisible, function: _hidePreview),
            //     // _previewItem(namaProduk: globalNamaProduk, kategoriProduk: globalKategoriProduk, fotoProduk: globalFotoProduk),
            //     // _blackScreen(visible: _isBlackScreenForFilterHeaderVisible, function: _showFilterDropdown),
            //     // _floatingDropDownHeader(
            //     //   text: "Filter",
            //     //   visible: _isFilterButtonFloated,
            //     //   topPositioned: _filterSortButtonTopPosition,
            //     //   leftPositioned: 152,
            //     //   mainFunction: _showFilterDropdown,
            //     //   icon: Icons.tune,
            //     //   isSecondIconRotated: _isFilterHeaderArrowRotated,
            //     //   animatedRadius: _isDropdownHeaderRadiusAnimated
            //     // ),
            //     // _blackScreen(visible: _isBlackScreenForSortHeaderVisible, function: _showSortDropdown),
            //     // _floatingDropDownHeader(
            //     //   text: "Urutkan",
            //     //   visible: _isSortButtonFloated,
            //     //   topPositioned: _filterSortButtonTopPosition,
            //     //   leftPositioned: 274,
            //     //   icon: Icons.sort,
            //     //   isSecondIconRotated: _isSortHeaderArrowRotated,
            //     //   mainFunction: _showSortDropdown,
            //     //   animatedRadius: _isDropdownHeaderRadiusAnimated
            //     // ),
            //     // _blackScreen(visible: _isBlackScreenForSearchBarVisible, function: null),
            //     // _floatingDropDownHeader(
            //     //   text: "Cari",
            //     //   visible: _isSearchBarFloated,
            //     //   topPositioned: 10,
            //     //   leftPositioned: 18,
            //     //   width: _searchBarWidth,
            //     //   icon: Icons.search,
            //     //   secondIcon: Icons.cancel,
            //     //   secondIconColor: _isSearchBarExpanded? Colors.black : Colors.transparent,
            //     //   secondIconFunction: _expandSearchBar,
            //     //   mainFunction: _isSearchBarExpanded? null : _expandSearchBar
            //     // ),
            //     // _floatingDropDownMenuFrame(triggeredBy: _currentTrigger, sizeFactor: _dropdownController, dropdownItems: _getWidgetMenuItem(items: _currentDropDownValue)),

            //     // itemTile(
            //     //   gambarProduk: state.listofProdukData[index].gambarProduk!,
            //     //   harga: state.listofProdukData[index].harga!,
            //     //   idProduk: state.listofProdukData[index].documentID!,
            //     //   jumlahStok: state.listofProdukData[index].jumlahStok!,
            //     //   kategoriProduk: state.listofProdukData[index].kategoriProduk!,
            //     //   namaProduk: state.listofProdukData[index].namaProduk!,
            //     //   merekProduk: state.listofProdukData[index].merekProduk!,
            //     // )
            //   ]
            // )
            ),
        _blackScreen(visible: _isBlackScreenForAppBarDropdownMenuVisible, function: _showAppBarDropdownMenu),
        _floatingAppBarDropdownMenuButton(),
        _floatingAppBarDropdownMenu()
      ],
    );
  }

  // Custom Variables
  Alignment _alignPreview2 = Alignment.bottomCenter;

  bool _isSearchBarExpanded = false;
  bool _isSearchBarLeftAligned = false;
  bool _isAppBarMenuButtonFloated = false;
  bool _isAppBarDropdownMenuOpened = false;
  bool _isBlackScreenFadeIn = false;
  bool _isBlackScreenVisible = false;
  bool _isBlackScreenForAppBarDropdownMenuVisible = false;
  bool _isBlackScreenForFilterHeaderVisible = false;
  bool _isBlackScreenForSearchBarVisible = false;
  bool _isBlackScreenForSortHeaderVisible = false;
  bool _isDropdownHeaderRadiusAnimated = false;
  bool _isFilterButtonFloated = false;
  bool _isFilterButtonVisible = true;
  bool _isFilterDropDownOpened = false;
  bool _isFilterHeaderArrowRotated = false;
  bool _isSearchBarFloated = false;
  bool _isSeparatorLineVisible = true;
  bool _isSortButtonVisible = true;
  bool _isSortButtonFloated = false;
  bool _isSortDropDownOpened = false;
  bool _isSortHeaderArrowRotated = false;
  double _filterSortButtonTopPosition = 10;
  double _searchBarWidth = 120;
  double sliverAppBarSize = 50; //default minimum size from flutter
  String _currentTrigger = "";
  var _currentDropDownValue = [];
  var _filterDropdownItemValue = ["Alat Tulis", "Buku Cetak dan Majalah", "Buku Tulis & Buku Gambar", "Peralatan olahraga"];
  var _sortDropdownItemValue = ["Harga Terendah", "Harga Tertinggi", "Nama Produk (A-Z)", "Nama Produk (Z-A)"];
  var _dropDownItemColor = [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent];

  late AnimationController _dropdownController = AnimationController(duration: Duration(milliseconds: 800), vsync: this); //..repeat();
  late AnimationController _showPreviewController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  late AnimationController _showAppBarDropdownMenuController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);

  late Animation<double> _dropDownAnimation = CurvedAnimation(parent: _dropdownController, curve: Curves.fastOutSlowIn);
  late Animation<double> _showPreviewAnimation = CurvedAnimation(parent: _showPreviewController, curve: Curves.fastOutSlowIn);
  late Animation<double> _showAppBarDropdownMenuAnimation = CurvedAnimation(parent: _showAppBarDropdownMenuController, curve: Curves.fastOutSlowIn);

  @override
  void dispose() {
    _dropdownController.dispose();
    _showPreviewController.dispose();
    // _sortDropDownController.dispose();
    // _deliveryOptionController.dispose();
    super.dispose();
  }

  // Custom Void
  // void _showBlackScreen() {
  //   if (!_isBlackScreenVisible) {
  //     setState(() {
  //       _isBlackScreenVisible = true;
  //     });
  //     Future.delayed(Duration(milliseconds: 100), () {
  //       setState(() {
  //         _isBlackScreenFadeIn = true;
  //       });
  //     });
  //   }
  // }s

  List<Widget> _getWidgetMenuItem({required var items, bool addIcon = false, var iconItems, var function}) {
    List<Widget> dropdownItems = [];
    var temp;
    var localIconItems;
    var localFunction;

    for (int i = 0; i < items.length; i++) {
      if (iconItems == null)
        localIconItems = Icons.question_mark;
      else
        localIconItems = iconItems[i];
      if (function == null)
        localFunction = () {};
      else
        localFunction = function[i];
      temp = _dropDownMenuItem(textMenu: items[i], colorMenu: _dropDownItemColor[i], addIcon: addIcon, icon: localIconItems, function: localFunction); // untuk sementara, "_dropDownItemColor" tidak diganti.
      dropdownItems.add(temp);
    }
    return dropdownItems;
  }

  void _expandSearchBar() async {
    int duration = 500;
    int i = 0;
    double increment = 1;

    setState(() {
      _isSearchBarExpanded = !_isSearchBarExpanded;
    });
    if (_isSearchBarExpanded) {
      setState(() {
        _isSearchBarLeftAligned = !_isSearchBarLeftAligned;
        _isSeparatorLineVisible = !_isSeparatorLineVisible;
        _isFilterButtonVisible = !_isFilterButtonVisible;
        _isSortButtonVisible = !_isSortButtonVisible;
        _isFilterButtonFloated = !_isFilterButtonFloated;
        _isSortButtonFloated = !_isSortButtonFloated;
        _isSearchBarFloated = !_isSearchBarFloated;
        _isBlackScreenForSearchBarVisible = !_isBlackScreenForSearchBarVisible;
      });
      while (sliverAppBarSize.toInt() < 100) {
        await Future.delayed(Duration(microseconds: duration));
        setState(() {
          sliverAppBarSize += increment;
          _filterSortButtonTopPosition += 0.9;
        });
        // print('i: $i, textValue: $testValue, topPos: $_filterSortButtonTopPosition');
        i++;
      }
      setState(() {
        _searchBarWidth = (MediaQuery.of(context).size.width) - 32.4285714286;
        _isBlackScreenFadeIn = !_isBlackScreenFadeIn;
      });
    } else {
      setState(() {
        _searchBarWidth = 120;
      });
      await Future.delayed(Duration(milliseconds: 800)); // Waiting for resize search bar done
      setState(() {
        _isBlackScreenFadeIn = !_isBlackScreenFadeIn;
      });
      while (sliverAppBarSize.toInt() > 50) {
        await Future.delayed(Duration(microseconds: duration));
        setState(() {
          sliverAppBarSize -= increment;
          _filterSortButtonTopPosition -= 0.9;
        });
        // print('i: $i, textValue: $testValue, topPos: $_filterSortButtonTopPosition');
        i++;
      }
      setState(() {
        _isSearchBarLeftAligned = !_isSearchBarLeftAligned;
        _isSeparatorLineVisible = !_isSeparatorLineVisible;
        _isFilterButtonVisible = !_isFilterButtonVisible;
        _isSortButtonVisible = !_isSortButtonVisible;
        _isFilterButtonFloated = !_isFilterButtonFloated;
        _isSortButtonFloated = !_isSortButtonFloated;
        _isSearchBarFloated = !_isSearchBarFloated;
        _isBlackScreenForSearchBarVisible = !_isBlackScreenForSearchBarVisible;
      });
    }
    // print("Done");
  }

  void _hidePreview() {
    if (_isBlackScreenVisible) {
      setState(() {
        _isBlackScreenFadeIn = false;
        _alignPreview2 = Alignment.bottomCenter;
      });
      Future.delayed(Duration(milliseconds: 218), () {
        setState(() {
          _showPreviewController.reverse();
        });
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _isBlackScreenVisible = false;
        });
      });
    }
  }

  void _showAppBarDropdownMenu() {
    setState(() {
      _isAppBarMenuButtonFloated = true;
      _isBlackScreenForAppBarDropdownMenuVisible = true;
      _isAppBarDropdownMenuOpened = !_isAppBarDropdownMenuOpened;
      if (_isAppBarDropdownMenuOpened) {
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            _showAppBarDropdownMenuController.forward();
            _isBlackScreenFadeIn = true;
          });
        });
      } else {
        _showAppBarDropdownMenuController.reverse();
        _isBlackScreenFadeIn = false;
        Future.delayed(Duration(milliseconds: 800), () {
          setState(() {
            _isBlackScreenForAppBarDropdownMenuVisible = false;
            _isAppBarMenuButtonFloated = false;
          });
        });
      }
    });
  }

  void _showFilterDropdown() {
    setState(() {
      _currentTrigger = "filter";
      _currentDropDownValue = _filterDropdownItemValue;
      _isFilterButtonFloated = true;
      _isBlackScreenForFilterHeaderVisible = true;
      _isFilterDropDownOpened = !_isFilterDropDownOpened;
      if (_isFilterDropDownOpened) {
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            _dropdownController.forward();
            _isBlackScreenFadeIn = true;
            _isDropdownHeaderRadiusAnimated = true;
            _isFilterHeaderArrowRotated = true;
          });
        });
      } else {
        _dropdownController.reverse();
        _isBlackScreenFadeIn = false;
        _isFilterHeaderArrowRotated = false;
        Future.delayed(Duration(milliseconds: 800), () {
          setState(() {
            _isBlackScreenForFilterHeaderVisible = false;
            _isDropdownHeaderRadiusAnimated = false;
            _isFilterButtonFloated = false;
          });
        });
      }
    });
  }

  void _showPreview() {
    if (!_isBlackScreenVisible) {
      setState(() {
        _isBlackScreenVisible = true;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          _isBlackScreenFadeIn = true;
          _showPreviewController.forward();
        });
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _alignPreview2 = Alignment.center;
        });
      });
    }
  }

  void _showSortDropdown() {
    setState(() {
      _currentTrigger = "sort";
      _currentDropDownValue = _sortDropdownItemValue;
      _isSortButtonFloated = true;
      _isBlackScreenForSortHeaderVisible = true;
      _isSortDropDownOpened = !_isSortDropDownOpened;
      if (_isSortDropDownOpened) {
        Future.delayed(Duration(milliseconds: 100), () {
          setState(() {
            _dropdownController.forward();
            _isBlackScreenFadeIn = true;
            _isDropdownHeaderRadiusAnimated = true;
            _isSortHeaderArrowRotated = true;
          });
        });
      } else {
        _dropdownController.reverse();
        _isBlackScreenFadeIn = false;
        _isSortHeaderArrowRotated = false;
        Future.delayed(Duration(milliseconds: 800), () {
          setState(() {
            _isBlackScreenForSortHeaderVisible = false;
            _isDropdownHeaderRadiusAnimated = false;
            _isSortButtonFloated = false;
          });
        });
      }
    });
  }

  // Custom Widget
  Widget _blackScreen({required bool visible, required void Function()? function}) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: [
          Expanded(
            child: Visibility(
              visible: visible,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity: _isBlackScreenFadeIn ? 0.5 : 0,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({required String text, bool textBold = false, double textSize = 14, Color color = Colors.white, bool addIcon = false}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      // padding: EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(3, 3),
          blurRadius: 5,
          spreadRadius: 1,
        )
      ]),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: () {},
          splashColor: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                addIcon
                    ? Icon(
                        Icons.add_shopping_cart,
                      )
                    : Container(),
                Text(text,
                    style: TextStyle(
                      fontSize: textSize,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropDownHeader({double width = 120, bool animatedRadius = false, required String text, required IconData icon, IconData secondIcon = Icons.arrow_drop_down, bool isSecondIconRotated = false, Color secondIconColor = Colors.black, required void Function()? mainFunction, void Function()? secondIconFunction}) {
    // Widget _dropDownHeader({required String text, required IconData icon}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
      width: width,
      // padding: EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(), borderRadius: animatedRadius ? BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)) : BorderRadius.circular(15), color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade800,
          offset: Offset(3, 3),
          blurRadius: 5,
          spreadRadius: 1,
        )
      ]),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.black.withOpacity(0.1),
          onTap: mainFunction,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(_currentDropDownValue),
                Icon(
                  //left side icon
                  icon,
                  color: Colors.black,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: secondIconFunction,
                  child: AnimatedRotation(
                    turns: isSecondIconRotated ? 0.5 : 0,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn,
                    child: Icon(
                      //right side icon
                      secondIcon,
                      color: secondIconColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingAppBarDropdownMenu() {
    var dropdownItems = ["Home", "Keranjang"];
    var dropdownIcons = [Icons.home, Icons.shopping_cart_outlined];

    var dropdownFunctions;
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   dropdownFunctions = [
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) {
    //           return homePage();
    //         }
    //       ),
    //     ModalRoute.withName("/Home")
    //     ),
    //     Navigator.push(
    //       context, MaterialPageRoute(
    //         builder: (context) {
    //           return keranjangPage();
    //         }
    //       )
    //     )
    //   ];
    // });
    return Positioned(
      top: 70,
      right: 10,
      child: Row(
        children: [
          SizeTransition(
            axis: Axis.vertical,
            sizeFactor: _showAppBarDropdownMenuController,
            child: Container(
              padding: EdgeInsets.all(10),
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15), topLeft: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  for (Widget dropdownItemsWidget in _getWidgetMenuItem(items: dropdownItems, addIcon: true, iconItems: dropdownIcons, function: dropdownFunctions)) (dropdownItemsWidget),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingAppBarDropdownMenuButton() {
    return Visibility(
        visible: _isAppBarMenuButtonFloated,
        child: Positioned(
          top: 28,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: _showAppBarDropdownMenu,
            ),
          ),
        ));
  }

  Widget _floatingDropDownHeader({bool visible = false, double topPositioned = 0, double leftPositioned = 0, double width = 120, bool animatedRadius = false, required String text, required IconData icon, IconData secondIcon = Icons.arrow_drop_down, bool isSecondIconRotated = false, Color secondIconColor = Colors.black, required void Function()? mainFunction, void Function()? secondIconFunction}) {
    return Visibility(visible: visible, child: Positioned(top: topPositioned, left: leftPositioned, child: _dropDownHeader(width: width, animatedRadius: animatedRadius, text: text, icon: icon, secondIcon: secondIcon, secondIconColor: secondIconColor, isSecondIconRotated: isSecondIconRotated, mainFunction: mainFunction, secondIconFunction: secondIconFunction)));
  }

  Widget _floatingDropDownMenuFrame({required String triggeredBy, required Animation<double> sizeFactor, required List<Widget> dropdownItems}) {
    return Positioned(
      top: 48,
      left: triggeredBy == "filter" ? 152 : 195,
      child: Row(
        children: [
          SizeTransition(
            axis: Axis.vertical,
            sizeFactor: sizeFactor,
            child: Container(
              padding: EdgeInsets.all(10),
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15), topLeft: triggeredBy == "sort" ? Radius.circular(15) : Radius.circular(0), topRight: triggeredBy == "filter" ? Radius.circular(15) : Radius.circular(0)),
              ),
              child: Column(
                children: [
                  Align(alignment: Alignment.centerLeft, child: Text(triggeredBy == "filter" ? "Kategori" : "Berdasarkan")),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  for (Widget dropdownItemsWidget in dropdownItems) (dropdownItemsWidget),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(15), color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade800,
                            offset: Offset(3, 3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ]),
                        child: Text("Tampilkan")),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropDownMenuItem({required String textMenu, required Color colorMenu, bool addIcon = false, IconData icon = Icons.question_mark, void Function()? function}) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(15), color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade800,
                  offset: Offset(3, 3),
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ]),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  splashColor: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                  onTap: function,
                  child: addIcon
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(icon),
                            Text(textMenu),
                          ],
                        )
                      : Text(textMenu),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _item_regularShape({int index = 0, double height = 0, double width = 180, bool showButtons = false, bool turnOffSplashEffect = false, String namaProduk = "", required String kategoriProduk, String fotoProduk = ""}) {
    return Container(
      key: ValueKey(index),
      clipBehavior: Clip.antiAlias,
      height: height,
      width: width,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(3, 3),
          blurRadius: 5,
          spreadRadius: 1,
        )
      ]),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: turnOffSplashEffect ? null : _showPreview,
          splashColor: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Ink.image(
                height: 180,
                width: 180,
                // colorFilter: ColorFilter.mode(Colors.purple, BlendMode.color),
                image: (fotoProduk != "") ? NetworkImage(fotoProduk) : AssetImage('assets/images/home_Beli ATK.jpg') as ImageProvider,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // "Item Produk ke-${index + 1}",
                      namaProduk,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    // Text(
                    //   kategoriProduk,
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //   )
                    // ),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance.collection('kategori').doc(kategoriProduk).get(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data();
                          var value;
                          if (data != null)
                            value = data['kategori'];
                          else
                            value = "[Kategori Produk tidak ditemukan]";
                          return Text(value, style: TextStyle(color: Colors.grey));
                        }
                        return Center(child: Text('[Kategori Produk]'));
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Text("10.000[!]", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    showButtons
                      ? Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.green,
                                elevation: 5,
                                child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    splashColor: Colors.white.withOpacity(0.8),
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 10,
                                        child: Text("-", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 15,
                                child: Text("1", style: TextStyle(color: Colors.black)),
                              ),
                              Material(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.green,
                                elevation: 5,
                                child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    splashColor: Colors.white.withOpacity(0.8),
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 10,
                                        child: Text("+", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                              ),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              Expanded(child: _button(addIcon: true, text: "Keranjang", textSize: 16)),
                            ],
                          ))
                      : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item_rowShape() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15), boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(3, 3),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ]),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Ink.image(
                    height: 60,
                    width: 60,
                    // colorFilter: ColorFilter.mode(Colors.purple, BlendMode.color),
                    image: AssetImage('assets/images/home_Beli ATK.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                // Text(
                //   _text,
                //   style: TextStyle(
                //     fontSize: 18
                //   )
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _previewItem({String namaProduk = "", required String kategoriProduk, String fotoProduk = ""}) {
    double _previewItemHeight = 370;
    double _previewItemWidth = 300;
    return
        // Visibility(
        //   visible: _isBlackScreenVisible,
        // child:
        Row(
      children: [
        Expanded(
            child: Column(
          children: [
            Expanded(
              child: AnimatedAlign(
                  // alignment: Alignment.bottomCenter,
                  alignment: _alignPreview2,
                  curve: Curves.fastOutSlowIn,
                  // curve: Curves.ease,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    height: _previewItemHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizeTransition(
                            axis: Axis.vertical,
                            axisAlignment: -1,
                            sizeFactor: _showPreviewController,
                            child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    StreamBuilder<Object>(
                                        stream: null,
                                        builder: (_, snapshot) {
                                          return _item_regularShape(
                                              height: _previewItemHeight,
                                              width: _previewItemWidth,
                                              showButtons: true, //add button widget
                                              turnOffSplashEffect: true,
                                              namaProduk: globalNamaProduk,
                                              kategoriProduk: globalKategoriProduk,
                                              fotoProduk: globalFotoProduk);
                                        }),
                                    Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: _hidePreview,
                                        child: Icon(Icons.cancel, color: Colors.red, size: 30),
                                      ),
                                    )
                                  ],
                                ))),
                      ],
                    ),
                  )),
            ),
          ],
        )),
      ],
    );
  }

  // Widget _sliver() {
  //   return Container(
  //     color: Colors.white,
  //     child: StreamBuilder<QuerySnapshot>(
  //         stream: _productStream,
  //         builder: (context, snapshot) {
  //           if (snapshot.hasError) {
  //             print("Data ada yang salah");
  //           }
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(child: CircularProgressIndicator());
  //           }
  //           return CustomScrollView(slivers: [
  //             // SliverAppBar(
  //             //   automaticallyImplyLeading: false,
  //             //   backgroundColor: Colors.purple[300],
  //             //   centerTitle: true,
  //             //   expandedHeight: sliverAppBarSize, //default: 50, expected: 100
  //             //   floating: true,
  //             //   shape: RoundedRectangleBorder(
  //             //     borderRadius: BorderRadius.only(
  //             //       bottomLeft: Radius.circular(25),
  //             //       bottomRight: Radius.circular(25)
  //             //     )
  //             //   ),
  //             //     // titleTextStyle: TextStyle(
  //             //     //   color: Colors.black,
  //             //     //   fontSize: 16
  //             //     // ),
  //             //     // flexibleSpace: Row(
  //             //     //   children: [
  //             //     //     Expanded(
  //             //     //       child: Container(
  //             //     //         color: Colors.yellow,
  //             //     //       ),
  //             //     //     ),
  //             //     //   ],
  //             //     // ),
  //             //   title: Row(
  //             //     // mainAxisAlignment: _isSearchBarLeftAligned? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
  //             //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             //     children: [
  //             //       Visibility(
  //             //         visible: _isSearchBarFloated? false : true,
  //             //         child: _dropDownHeader(
  //             //           // width: _searchBarWidth,
  //             //           text: "Cari",
  //             //           icon: Icons.search,
  //             //           // secondIcon: Icons.cancel,
  //             //           // secondIconColor: _isSearchBarExpanded? Colors.black : Colors.transparent,
  //             //           secondIconColor: Colors.transparent,
  //             //           // secondIconFunction: _expandSearchBar,
  //             //           // mainFunction: _isSearchBarExpanded? null : _expandSearchBar
  //             //           mainFunction: _expandSearchBar
  //             //         ),
  //             //       ),
  //             //       Visibility( // Separator Line
  //             //         visible: _isSeparatorLineVisible,
  //             //         child: Padding(
  //             //           padding: EdgeInsets.all(5),
  //             //           child: Container(
  //             //             padding: EdgeInsets.all(15),
  //             //             color: Colors.white,
  //             //             width: 1,
  //             //             child: Text(""),
  //             //           ),
  //             //         ),
  //             //       ),
  //             //       Visibility(
  //             //         visible: _isFilterButtonVisible,
  //             //         child: _dropDownHeader(text: "Filter", icon: Icons.tune, mainFunction: _showFilterDropdown)
  //             //       ),
  //             //       Visibility(
  //             //         visible: _isSortButtonVisible,
  //             //         child: _dropDownHeader(text: "Urutkan", icon: Icons.sort, mainFunction: _showSortDropdown)
  //             //       ),
  //             //     ],
  //             //   )
  //             // ),
  //             SliverPadding(
  //               padding: EdgeInsets.all(15),
  //               sliver: SliverGrid(
  //                 delegate: SliverChildBuilderDelegate((context, index) {
  //                   // setState(() {
  //                   globalNamaProduk = snapshot.data!.docs[index]['namaProduk'];
  //                   globalKategoriProduk = snapshot.data!.docs[index]['kategoriProduk'];
  //                   globalFotoProduk = snapshot.data!.docs[index]['gambarProduk'];
  //                   globalIndex = index;
  //                   // });
  //                   return _item_regularShape(index: index, namaProduk: "${snapshot.data!.docs[index]['namaProduk']}", kategoriProduk: "${snapshot.data!.docs[index]['kategoriProduk']}", fotoProduk: "${snapshot.data!.docs[index]['gambarProduk']}");
  //                 },
  //                     // childCount: 2,
  //                     childCount: snapshot.data!.size),
  //                 // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //                     maxCrossAxisExtent: 180,
  //                     mainAxisSpacing: 15,
  //                     crossAxisSpacing: 15,
  //                     // childAspectRatio: 1 / 1.7
  //                     mainAxisExtent: 310),
  //               ),
  //             )
  //           ]);
  //         }),
  //   );
  // }
}
