import 'package:Aayan/models/BrandModel.dart';
import 'package:Aayan/models/FilterVehicleModel.dart';
import 'package:Aayan/models/VehicleDetailModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/providers/app_provider.dart';
import 'package:Aayan/screens/compare/CompareLeaseScreen.dart';
import 'package:Aayan/screens/filter/FilterLeaseVehicleScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleDetailsScreen.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleSearchScreen.dart';
import 'package:Aayan/screens/login/LoginScreen.dart';
import 'package:Aayan/services/HttpService.dart';
import 'package:Aayan/util/aayan_icons.dart';
import 'package:Aayan/widgets/app_filled_button.dart';
import 'package:Aayan/widgets/app_transparent_button.dart';
import 'package:Aayan/widgets/filter_brand_tile.dart';
import 'package:Aayan/widgets/vehicle_full_width_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaseVehicleScreen extends StatefulWidget {
  static final String routeName = '/lease-vehicle';

  @override
  _LeaseVehicleScreenState createState() => _LeaseVehicleScreenState();
}

class _LeaseVehicleScreenState extends State<LeaseVehicleScreen> {
  List<String> selectedIds = [];
  bool isLoading = true;
  bool isFetching = false;
  bool searchMode = false;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    scrollController.addListener(() async{
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
        if (Provider
            .of<AppProvider>(context, listen: false)
            .getLeasePageInfoModel
            .currentPage < Provider
            .of<AppProvider>(context, listen: false)
            .getLeasePageInfoModel
            .lastPage){
          Provider
              .of<AppProvider>(context, listen: false)
              .getLeasePageInfoModel
              .incrementPageNumber();
          if (selectedIds.isNotEmpty) {
            setState(() {
              isFetching = true;
            });
            isFetching = await HttpService.getLeaseVehiclesByFilter(context,
                ids: selectedIds);
          } else if (searchMode) {
            setState(() {
              isFetching = true;
            });
            isFetching = await HttpService.getLeaseVehiclesBySearch(context,
                key: searchController.text);
          } else if (Provider
              .of<AppProvider>(context, listen: false)
              .getLeaseFilterVehicleModel
              .brand != null || Provider
              .of<AppProvider>(context, listen: false)
              .getLeaseFilterVehicleModel
              .minPrice != null|| Provider
              .of<AppProvider>(context, listen: false)
              .getLeaseFilterVehicleModel
              .maxPrice != null) {
            setState(() {
              isFetching = true;
            });
            isFetching = await HttpService.getLeaseVehiclesWithFilter(context,
                Provider
                    .of<AppProvider>(context, listen: false)
                    .getLeaseFilterVehicleModel);
          } else {
            setState(() {
              isFetching = true;
            });
            isFetching = await HttpService.getLeaseVehiclesByFilter(context,
                ids: []);
          }
          setState(() {

          });
        }
      }
    });
    Future.delayed(Duration.zero, () async {
      Provider.of<AppProvider>(context, listen: false).getLeasePageInfoModel.currentPage=1;
      isLoading = await HttpService.getLeaseVehiclesByFilter(context,
          ids: Provider.of<AppProvider>(context, listen: false)
              .getLeaseVehicleSelectedIds());
      selectedIds = Provider.of<AppProvider>(context, listen: false)
          .getLeaseVehicleSelectedIds();

      setState(() {
        isLoading = false;
      });
    });

    if (Provider.of<AppProvider>(context, listen: false)
        .getBrandList()
        .isEmpty) {
      HttpService.getBrands(context);
    }
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    if (searchMode) {
      selectedIds.clear();
      _filter();
      setState(() {
        searchMode = false;
      });
      return false;
    } else {
      return true;
    }
    // return
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: !searchMode
            ? AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.black),
                title: Text(
                  '${AppLocalizations.of(context).leaseVehicle}',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        AayanIcons.filter,
                        color: _appProvider.getLeaseFilterVehicleModel.brand != null||_appProvider.getLeaseFilterVehicleModel.minPrice != null||_appProvider.getLeaseFilterVehicleModel.maxPrice != null
                            ? Theme.of(context).primaryColor
                            : null,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(FilterLeaseVehicleScreen.routeName);
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.compare_arrows_rounded,
                        size: 28,
                      ),
                      onPressed: () {
                        Provider.of<AppProvider>(context, listen: false)
                            .getAddLeaseVehicleList()
                            .clear();
                        Navigator.of(context)
                            .pushNamed(CompareLeaseVehicleScreen.routeName);
                      }),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          searchMode = true;
                        });
                      }),
                ],
              )
            : AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.black),
                title: Center(
                  child: Container(
                    child: TextFormField(
                      style: TextStyle(color: Color(0xFF212121), fontSize: 14),
                      keyboardType: TextInputType.visiblePassword,
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      autofocus: true,
                      onFieldSubmitted: (val) {
                        _search();
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        hintText:
                            '${AppLocalizations.of(context).search} ${AppLocalizations.of(context).leaseVehicle}',
                        hintStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1)),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _appProvider.getLeaseVehicleList().isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 64),
                          itemCount: isFetching?_appProvider.getLeaseVehicleList().length+1: _appProvider.getLeaseVehicleList().length,
                          itemBuilder: (context, index) {
                            if(index>=_appProvider.getLeaseVehicleList().length){
                              print('${_appProvider.getLeasePageInfoModel.currentPage}!=${_appProvider.getLeasePageInfoModel.lastPage}');
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Center(child: SizedBox(height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator())),
                              );
                            }
                            VehicleModel vehicle =
                                _appProvider.getLeaseVehicleList()[index];
                            return VehicleFullWidthTile(
                              imageUrl: vehicle.imageName,
                              name: vehicle.carName,
                              year: vehicle.year,
                              brand: vehicle.brand,
                              model: vehicle.model,
                              price: 'KD ${vehicle.price}',
                              onPressed: () {
                                Provider.of<AppProvider>(context, listen: false)
                                    .setTempLeaseVehicle(vehicle);
                                Provider.of<AppProvider>(context, listen: false)
                                    .setTempLeaseVehicleDetail(
                                        VehicleDetailModel(
                                  id: vehicle.id,
                                  brand: vehicle.brand,
                                  model: vehicle.model,
                                  imageName: vehicle.imageName,
                                  carName: vehicle.carName,
                                  price: vehicle.price,
                                  year: vehicle.year,
                                  feature: vehicle.feature,
                                  createdAt: vehicle.createdAt,
                                  deletedAt: vehicle.deletedAt,
                                  updatedAt: vehicle.updatedAt,
                                  status: vehicle.status,
                                  mileage: vehicle.mileage,
                                ));
                                Navigator.of(context).pushNamed(
                                    LeaseVehicleDetailsScreen.routeName);
                              },
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                            child: Text(
                                '${AppLocalizations.of(context).noResults}')))
              ],
            ),
            Visibility(
                visible: isLoading,
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(child: CircularProgressIndicator()),
                )),
          ],
        ),
        /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: !searchMode,
          child: FloatingActionButton.extended(
            onPressed: () {
              _showFilterSheet();
            },
            label: Text('${AppLocalizations.of(context).filter}'),
            icon: Icon(Icons.filter_list),
          ),
        ),*/
      ),
    );
  }

  void _showFilterSheet() async {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              List<BrandModel> brandList =
                  Provider.of<AppProvider>(context, listen: true).brandList;
              return Container(
                padding: EdgeInsets.only(
                    top: 24,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    right: 16,
                    left: 16),
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: MediaQuery.of(context).size.height * 0.575,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 3,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int j = 0; j < brandList.length; j++)
                              FilterBrandTile(
                                imageUrl: brandList[j].image,
                                name: brandList[j].title,
                                isChecked:
                                    selectedIds.contains(brandList[j].id),
                                onPressed: selectedIds.contains(brandList[j].id)
                                    ? () {
                                        selectedIds.remove(brandList[j].id);
                                        setState(() {});
                                      }
                                    : () {
                                        selectedIds.add(brandList[j].id);
                                        setState(() {});
                                      },
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTransparentButton(
                              onPressed: () {
                                selectedIds.clear();
                                _filter();
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                '${AppLocalizations.of(context).reset}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            child: AppFilledButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _filter();
                              },
                              fillColor: Theme.of(context).primaryColor,
                              child: Text(
                                '${AppLocalizations.of(context).filter}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void _filter() async {
    setState(() {
      isLoading = true;
    });
    isLoading =
        await HttpService.getLeaseVehiclesByFilter(context, ids: selectedIds);
    setState(() {});
  }

  void _search() async {
    Provider.of<AppProvider>(context, listen: false).getLeasePageInfoModel.currentPage=1;
    setState(() {
      isLoading = true;
    });
    isLoading = await HttpService.getLeaseVehiclesBySearch(context,
        key: searchController.text);
    setState(() {});
  }
}
