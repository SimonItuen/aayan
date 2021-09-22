import 'package:Aayan/models/AboutUsModel.dart';
import 'package:Aayan/models/BannerModel.dart';
import 'package:Aayan/models/BrandModel.dart';
import 'package:Aayan/models/FeaturedVehicleModel.dart';
import 'package:Aayan/models/FilterVehicleModel.dart';
import 'package:Aayan/models/LeaseAddonItemModel.dart';
import 'package:Aayan/models/LeaseAddonModel.dart';
import 'package:Aayan/models/ModelModel.dart';
import 'package:Aayan/models/NotificationModel.dart';
import 'package:Aayan/models/PageInfoModel.dart';
import 'package:Aayan/models/SubModelModel.dart';
import 'package:Aayan/models/VehicleDetailModel.dart';
import 'package:Aayan/models/VehicleModel.dart';
import 'package:Aayan/models/UserModel.dart';
import 'package:Aayan/screens/lease_vehicle/LeaseVehicleDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  int currentTab = 0;
  String notificationId = '0';
  bool isNavOpen = false;
  bool isLoggedIn = false;
  bool isEnglish = true;
  bool isFreshLoggingIn = true;
  String tempMobileNumber = '';
  String contactUsMobileNumber = '';
  RangeValues leaseCarPriceRange;
  RangeValues usedCarPriceRange;
  int tempImagePageControllerIndex=0;
  PageInfoModel leaseScreenPageInfo = PageInfoModel();
  PageInfoModel usedScreenPageInfo = PageInfoModel();
  NotificationModel tempNotificationModel = NotificationModel();
  UserModel userModel = UserModel();
  AboutUsModel aboutUsModel = AboutUsModel();
  FilterVehicleModel usedFilterVehicleModel = FilterVehicleModel();
  FilterVehicleModel leaseFilterVehicleModel = FilterVehicleModel();
  List<NotificationModel> homeNotificationList = [];
  List<NotificationModel> notificationList = [];
  List<BannerModel> bannerList = [];
  List<BrandModel> brandList = [];
  List<BrandModel> usedBrandList = [];
  List<BrandModel> topBrandList = [];
  List<BrandModel> topUsedBrandList = [];
  List<ModelModel> _tempModelList = [];
  List<ModelModel> _tempUsedModelList = [];

  List<ModelModel> get tempModelList => _tempModelList;

  set tempModelList(List<ModelModel> value) {
    _tempModelList = value;
  }

  List<ModelModel> get tempUsedModelList => _tempUsedModelList;

  set tempUsedModelList(List<ModelModel> value) {
    _tempUsedModelList = value;
  }

  List<SubModelModel> _tempSubModelList = [];
  List<String> _tempYearList = [];
  List<String> _tempLeasePeriodList = [];
  List<SubModelModel> _tempUsedSubModelList = [];
  List<String> _tempUsedYearList = [];
  List<FeaturedVehicleModel> leaseFeaturedVehicleList = [];
  List<FeaturedVehicleModel> usedFeaturedVehicleList = [];
  List<VehicleModel> addLeaseVehicleList = [];
  List<VehicleModel> addUsedVehicleList = [];
  List<VehicleModel> compareLeaseVehicleList = [];
  List<VehicleModel> compareUsedVehicleList = [];
  List<VehicleModel> leaseVehicleList = [];
  List<VehicleModel> usedVehicleList = [];
  List<VehicleModel> homeLeaseVehicleList = [];
  List<VehicleModel> homeUsedVehicleList = [];
  List<VehicleModel> mostSearchedLeaseVehicleList = [];
  List<VehicleModel> mostSearchedUsedVehicleList = [];
  List<VehicleModel> mostRecentSearchedLeaseVehicleList = [];
  List<VehicleModel> mostRecentSearchedUsedVehicleList = [];
  VehicleDetailModel tempLeaseVehicleDetail = VehicleDetailModel();
  VehicleDetailModel tempUsedVehicleDetail = VehicleDetailModel();
  VehicleModel tempLeaseVehicle = VehicleModel();
  VehicleModel tempUsedVehicle = VehicleModel();
  List<LeaseAddonModel> leaseAddonList = [];
  List<LeaseAddonItemModel> valueLeaseAddonList = [];
  List<LeaseAddonItemModel> valuePlusLeaseAddonList = [];
  List<String> usedVehicleSelectedIds = [];
  List<String> leaseVehicleSelectedIds = [];
  List<String> addUsedAddVehicleSelectedIds = [];
  List<String> addLeaseVehicleSelectedIds = [];

  void setCurrentPage(int page) {
    currentTab = page;
    notifyListeners();
  }

  int get getCurrentPage {
    return currentTab;
  }

  void setLeaseCarPriceRange(RangeValues range) {
    leaseCarPriceRange = range;
    notifyListeners();
  }

  RangeValues get getLeaseCarPriceRange {
    return leaseCarPriceRange;
  }

  void setUsedCarPriceRange(RangeValues range) {
    usedCarPriceRange = range;
    notifyListeners();
  }

  RangeValues get getUsedCarPriceRange {
    return usedCarPriceRange;
  }

  void setTempImagePageControllerIndex(int index) {
    tempImagePageControllerIndex = index;
    notifyListeners();
  }

  int get getImagePageControllerIndex {
    return tempImagePageControllerIndex;
  }

  void setTempNotificationId(String id) {
    notificationId = id;
    notifyListeners();
  }

  void setTempNotificationModel(NotificationModel model) {
    tempNotificationModel = model;
    notifyListeners();
  }
  NotificationModel get getTempNotificationModel {
    return tempNotificationModel;
  }

  void setLeaseFilterVehicleModel(FilterVehicleModel model) {
    leaseFilterVehicleModel = model;
    notifyListeners();
  }

  FilterVehicleModel get getLeaseFilterVehicleModel {
    return leaseFilterVehicleModel;
  }

  void setUsedFilterVehicleModel(FilterVehicleModel model) {
    usedFilterVehicleModel = model;
    notifyListeners();
  }

  FilterVehicleModel get getUsedFilterVehicleModel {
    return usedFilterVehicleModel;
  }

  void setLeasePageInfo(PageInfoModel model) {
    leaseScreenPageInfo = model;
    notifyListeners();
  }

  PageInfoModel get getLeasePageInfoModel {
    return leaseScreenPageInfo;
  }

  void setUsedPageInfo(PageInfoModel model) {
    usedScreenPageInfo = model;
    notifyListeners();
  }

  PageInfoModel get getUsedPageInfoModel {
    return usedScreenPageInfo;
  }

  String get getTempNotificationId {
    return notificationId;
  }

  void toggleNavOpen() {
    isNavOpen = !isNavOpen;
    notifyListeners();
  }

  bool get getIsNavOpen {
    return isNavOpen;
  }

  void setIsLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }

  bool get getBoolIsLoggedIn {
    return isLoggedIn;
  }

  void setIsFreshLoggingIn(bool value) {
    isFreshLoggingIn = value;
    print('Them don make me $value');
    notifyListeners();
  }

  bool get getIsFreshLoggingIn {
    return isFreshLoggingIn;
  }

  void toggleLanguage() {
    isEnglish = !isEnglish;
    notifyListeners();
  }

  void setLanguage(bool isEnglish) {
    this.isEnglish = isEnglish;
    notifyListeners();
  }

  bool get getIsEnglish {
    return isEnglish;
  }

  void setTempMobileNumber(String val) {
    tempMobileNumber = val;
    notifyListeners();
  }

  String getTempMobileNumber() {
    return tempMobileNumber;
  }

  void setContactUsNumber(String val) {
    contactUsMobileNumber = val;
    notifyListeners();
  }

  String getContactUsNumber() {
    return contactUsMobileNumber;
  }

  void setAboutUsModel(AboutUsModel val) {
    aboutUsModel = val;
    notifyListeners();
  }

  AboutUsModel getAboutUsModel() {
    return aboutUsModel;
  }

  void setUserModel(UserModel model) {
    userModel = model;
    notifyListeners();
  }

  UserModel getCurrentUser() {
    return userModel;
  }

  void setHomeNotificationList(List<NotificationModel> list) {
    homeNotificationList = list;
    notifyListeners();
  }

  List<NotificationModel> getHomeNotificationList() {
    return homeNotificationList;
  }

  void setNotificationList(List<NotificationModel> list) {
    notificationList = list;
    notifyListeners();
  }

  List<NotificationModel> getNotificationList() {
    return notificationList;
  }
  void setBrandList(List<BrandModel> list) {
    brandList = list;
    notifyListeners();
  }

  List<BrandModel> getBrandList() {
    return brandList;
  }

  void setUsedBrandList(List<BrandModel> list) {
    usedBrandList = list;
    notifyListeners();
  }

  List<BrandModel> getUsedBrandList() {
    return usedBrandList;
  }

  void setTopBrandList(List<BrandModel> list) {
    topBrandList = list;
    notifyListeners();
  }

  List<BrandModel> getTopBrandList() {
    return topBrandList;
  }

  void setTopUsedBrandList(List<BrandModel> list) {
    topUsedBrandList = list;
    notifyListeners();
  }

  List<BrandModel> getTopUsedBrandList() {
    return topUsedBrandList;
  }

  void setUsedVehicleSelectedIds(List<String> list) {
    usedVehicleSelectedIds = list;
    notifyListeners();
  }

  List<String> getUsedVehicleSelectedIds() {
    return usedVehicleSelectedIds;
  }

  void setLeaseVehicleSelectedIds(List<String> list) {
    leaseVehicleSelectedIds = list;
    notifyListeners();
  }

  List<String> getLeaseVehicleSelectedIds() {
    return leaseVehicleSelectedIds;
  }

  void setAddUsedVehicleSelectedIds(List<String> list) {
    addUsedAddVehicleSelectedIds = list;
    notifyListeners();
  }

  List<String> getAddUsedVehicleSelectedIds() {
    return addUsedAddVehicleSelectedIds;
  }

  void setAddLeaseVehicleSelectedIds(List<String> list) {
    addLeaseVehicleSelectedIds = list;
    notifyListeners();
  }

  List<String> getAddLeaseVehicleSelectedIds() {
    return addLeaseVehicleSelectedIds;
  }

  void setBannerList(List<BannerModel> list) {
    bannerList = list;
    notifyListeners();
  }

  List<BannerModel> getBannerList() {
    return bannerList;
  }

  void setLeaseFeaturedVehicleList(List<FeaturedVehicleModel> list) {
    leaseFeaturedVehicleList = list;
    notifyListeners();
  }

  List<FeaturedVehicleModel> getLeaseFeaturedVehicleList() {
    return leaseFeaturedVehicleList;
  }

  void setUsedFeaturedVehicleList(List<FeaturedVehicleModel> list) {
    usedFeaturedVehicleList = list;
    notifyListeners();
  }

  List<FeaturedVehicleModel> getUsedFeaturedVehicleList() {
    return usedFeaturedVehicleList;
  }

  void setHomeLeaseVehicleList(List<VehicleModel> list) {
    homeLeaseVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getHomeLeaseVehicleList() {
    return homeLeaseVehicleList;
  }

  void setHomeUsedVehicleList(List<VehicleModel> list) {
    homeUsedVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getHomeUsedVehicleList() {
    return homeUsedVehicleList;
  }

  void setMostSearchedUsedVehicleList(List<VehicleModel> list) {
    mostSearchedUsedVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getMostSearchedUsedVehicleList() {
    return mostSearchedUsedVehicleList;
  }

  void setMostSearchedLeaseVehicleList(List<VehicleModel> list) {
    mostSearchedLeaseVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getMostSearchedLeaseVehicleList() {
    return mostSearchedLeaseVehicleList;
  }

  void setMostRecentSearchedUsedVehicleList(List<VehicleModel> list) {
    mostRecentSearchedUsedVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getMostRecentSearchedUsedVehicleList() {
    return mostRecentSearchedUsedVehicleList;
  }

  void setMostRecentSearchedLeaseVehicleList(List<VehicleModel> list) {
    mostRecentSearchedLeaseVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getMostRecentSearchedLeaseVehicleList() {
    return mostRecentSearchedLeaseVehicleList;
  }

  void setAddLeaseVehicleList(List<VehicleModel> list) {
    addLeaseVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getAddLeaseVehicleList() {
    return addLeaseVehicleList;
  }

  void setAddUsedVehicleList(List<VehicleModel> list) {
    addUsedVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getAddUsedVehicleList() {
    return addUsedVehicleList;
  }

  void setCompareLeaseVehicleList(List<VehicleModel> list) {
    compareLeaseVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getCompareLeaseVehicleList() {
    return compareLeaseVehicleList;
  }

  void setCompareUsedVehicleList(List<VehicleModel> list) {
    compareUsedVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getCompareUsedVehicleList() {
    return compareUsedVehicleList;
  }

  void setLeaseVehicleList(List<VehicleModel> list) {
    leaseVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getLeaseVehicleList() {
    return leaseVehicleList;
  }

  void setUsedVehicleList(List<VehicleModel> list) {
    usedVehicleList = list;
    notifyListeners();
  }

  List<VehicleModel> getUsedVehicleList() {
    return usedVehicleList;
  }

  void setTempLeaseVehicleDetail(VehicleDetailModel detail) {
    tempLeaseVehicleDetail = detail;
    notifyListeners();
  }

  VehicleDetailModel getTempLeaseVehicleDetail() {
    return tempLeaseVehicleDetail;
  }

  void setTempUsedVehicleDetail(VehicleDetailModel detail) {
    tempUsedVehicleDetail = detail;
    notifyListeners();
  }

  VehicleDetailModel getTempUsedVehicleDetail() {
    return tempUsedVehicleDetail;
  }

  void setTempLeaseVehicle(VehicleModel vehicle) {
    tempLeaseVehicle = vehicle;
    notifyListeners();
  }

  VehicleModel getTempLeaseVehicle() {
    return tempLeaseVehicle;
  }

  void setTempUsedVehicle(VehicleModel vehicle) {
    tempUsedVehicle = vehicle;
    notifyListeners();
  }

  VehicleModel getTempUsedVehicle() {
    return tempUsedVehicle;
  }

  void setLeaseAddonList(List<LeaseAddonModel> list) {
    leaseAddonList = list;
    notifyListeners();
  }

  List<LeaseAddonModel> getLeaseAddonList() {
    return leaseAddonList;
  }

  void setValueLeaseAddonList(List<LeaseAddonItemModel> list) {
    valueLeaseAddonList = list;
    notifyListeners();
  }

  List<LeaseAddonItemModel> getValueLeaseAddonList() {
    return valueLeaseAddonList;
  }

  void setValuePlusLeaseAddonList(List<LeaseAddonItemModel> list) {
    valuePlusLeaseAddonList = list;
    notifyListeners();
  }

  List<LeaseAddonItemModel> getValuePlusLeaseAddonList() {
    return valuePlusLeaseAddonList;
  }

  void reset() {
    currentTab = 0;
    isNavOpen = false;
    isLoggedIn = false;
    isFreshLoggingIn = true;
    tempMobileNumber = '';
    /*userModel = UserModel();
    brandList = [];
    bannerList = [];
    featuredVehicleList = [];
    leaseVehicleList = [];
    usedVehicleList = [];
    tempLeaseVehicleDetail = VehicleDetailModel();*/
    notifyListeners();
  }

  List<ModelModel> getTempModelList() {
    return _tempModelList;
  }

  void setTempModelList(List<ModelModel> value) {
    _tempModelList = value;
  }

  List<SubModelModel> getTempSubModelList() {
    return _tempSubModelList;
  }

  void setTempSubModelList(List<SubModelModel> value) {
    _tempSubModelList = value;
  }

  List<String> getTempYearList() {
    return _tempYearList;
  }

  void setTempYearList(List<String> value) {
    _tempYearList = value;
  }

  List<String> getTempLeasePeriodList() {
    return _tempLeasePeriodList;
  }

  void setTempLeasePeriodList(List<String> value) {
    _tempLeasePeriodList = value;
  }

  List<ModelModel> getTempUsedModelList() {
    return _tempUsedModelList;
  }

  void setTempUsedModelList(List<ModelModel> value) {
    _tempUsedModelList = value;
  }

  List<SubModelModel> getTempUsedSubModelList() {
    return _tempUsedSubModelList;
  }

  void setTempUsedSubModelList(List<SubModelModel> value) {
    _tempUsedSubModelList = value;
  }

  List<String> getTempUsedYearList() {
    return _tempUsedYearList;
  }

  void setTempUsedYearList(List<String> value) {
    _tempUsedYearList = value;
  }
}
