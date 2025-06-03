// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Publish Date`
  String get publishDate {
    return Intl.message(
      'Publish Date',
      name: 'publishDate',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message('Save', name: 'Save', desc: '', args: []);
  }

  /// `Address`
  String get Address {
    return Intl.message('Address', name: 'Address', desc: '', args: []);
  }

  /// `Close`
  String get Close {
    return Intl.message('Close', name: 'Close', desc: '', args: []);
  }

  /// `Select`
  String get Select {
    return Intl.message('Select', name: 'Select', desc: '', args: []);
  }

  /// `Select Date`
  String get SelectDate {
    return Intl.message('Select Date', name: 'SelectDate', desc: '', args: []);
  }

  /// `for sale`
  String get ForSale {
    return Intl.message('for sale', name: 'ForSale', desc: '', args: []);
  }

  /// `for rent`
  String get ForRent {
    return Intl.message('for rent', name: 'ForRent', desc: '', args: []);
  }

  /// `Create New Account`
  String get CreateNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'CreateNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message('Login', name: 'Login', desc: '', args: []);
  }

  /// `Email`
  String get Email {
    return Intl.message('Email', name: 'Email', desc: '', args: []);
  }

  /// `Password`
  String get Password {
    return Intl.message('Password', name: 'Password', desc: '', args: []);
  }

  /// `Forgot Password`
  String get ForgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'ForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get TermsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'TermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Restore Password`
  String get RestorePassword {
    return Intl.message(
      'Restore Password',
      name: 'RestorePassword',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get And {
    return Intl.message(' and ', name: 'And', desc: '', args: []);
  }

  /// `The process is simple, enter your email and we will send you a link to create a new password.`
  String
  get TheProcessIsSimpleEnterYourEmailAndWeWillSendYouALinkToCreateANewPassword {
    return Intl.message(
      'The process is simple, enter your email and we will send you a link to create a new password.',
      name:
          'TheProcessIsSimpleEnterYourEmailAndWeWillSendYouALinkToCreateANewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Did you forget your password?`
  String get DidYouForgetYourPassword {
    return Intl.message(
      'Did you forget your password?',
      name: 'DidYouForgetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `By continuing you agree to `
  String get ByContinuingYouAgreeTo {
    return Intl.message(
      'By continuing you agree to ',
      name: 'ByContinuingYouAgreeTo',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get FirstName {
    return Intl.message('First Name', name: 'FirstName', desc: '', args: []);
  }

  /// `Last Name`
  String get LastName {
    return Intl.message('Last Name', name: 'LastName', desc: '', args: []);
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get LoginWithGoogle {
    return Intl.message(
      'Login with Google',
      name: 'LoginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get LoginWithFacebook {
    return Intl.message(
      'Login with Facebook',
      name: 'LoginWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Login with Apple`
  String get LoginWithApple {
    return Intl.message(
      'Login with Apple',
      name: 'LoginWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Login with Email`
  String get LoginWithEmail {
    return Intl.message(
      'Login with Email',
      name: 'LoginWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Log in to access all features`
  String get LogInToAccessAllFeatures {
    return Intl.message(
      'Log in to access all features',
      name: 'LogInToAccessAllFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an Emtelek account? Create one`
  String get DontHaveAnEmtelekAccountCreateOne {
    return Intl.message(
      'Don\'t have an Emtelek account? Create one',
      name: 'DontHaveAnEmtelekAccountCreateOne',
      desc: '',
      args: [],
    );
  }

  /// `By logging in, you agree to `
  String get ByLoggingInYouAgreeTo {
    return Intl.message(
      'By logging in, you agree to ',
      name: 'ByLoggingInYouAgreeTo',
      desc: '',
      args: [],
    );
  }

  /// `Get Verified`
  String get GetVerified {
    return Intl.message(
      'Get Verified',
      name: 'GetVerified',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get Menu {
    return Intl.message('Menu', name: 'Menu', desc: '', args: []);
  }

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  /// `Favorites`
  String get Favorites {
    return Intl.message('Favorites', name: 'Favorites', desc: '', args: []);
  }

  /// `Place an Ad`
  String get PlaceAnAd {
    return Intl.message('Place an Ad', name: 'PlaceAnAd', desc: '', args: []);
  }

  /// `Joined on`
  String get JoinedOn {
    return Intl.message('Joined on', name: 'JoinedOn', desc: '', args: []);
  }

  /// `My Ads`
  String get MyAds {
    return Intl.message('My Ads', name: 'MyAds', desc: '', args: []);
  }

  /// `Search`
  String get Search {
    return Intl.message('Search', name: 'Search', desc: '', args: []);
  }

  /// `Write at least 3 characters`
  String get WriteThreeCharacters {
    return Intl.message(
      'Write at least 3 characters',
      name: 'WriteThreeCharacters',
      desc: '',
      args: [],
    );
  }

  /// `My Searches`
  String get MySearches {
    return Intl.message('My Searches', name: 'MySearches', desc: '', args: []);
  }

  /// `oops! Wrong`
  String get Error {
    return Intl.message('oops! Wrong', name: 'Error', desc: '', args: []);
  }

  /// `Hello`
  String get Hello {
    return Intl.message('Hello', name: 'Hello', desc: '', args: []);
  }

  /// `Sort`
  String get Sort {
    return Intl.message('Sort', name: 'Sort', desc: '', args: []);
  }

  /// `Price: Low to High`
  String get PriceLowToHigh {
    return Intl.message(
      'Price: Low to High',
      name: 'PriceLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `Price: High to Low`
  String get PriceHighToLow {
    return Intl.message(
      'Price: High to Low',
      name: 'PriceHighToLow',
      desc: '',
      args: [],
    );
  }

  /// `Date New to Old`
  String get DateNewToOld {
    return Intl.message(
      'Date New to Old',
      name: 'DateNewToOld',
      desc: '',
      args: [],
    );
  }

  /// `Date Old to New`
  String get DateOldToNew {
    return Intl.message(
      'Date Old to New',
      name: 'DateOldToNew',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get Clear {
    return Intl.message('Clear', name: 'Clear', desc: '', args: []);
  }

  /// `Ok`
  String get Ok {
    return Intl.message('Ok', name: 'Ok', desc: '', args: []);
  }

  /// `Clear All`
  String get ClearAll {
    return Intl.message('Clear All', name: 'ClearAll', desc: '', args: []);
  }

  /// `Fill in at least the required fields`
  String get AddAdWarning {
    return Intl.message(
      'Fill in at least the required fields',
      name: 'AddAdWarning',
      desc: '',
      args: [],
    );
  }

  /// `Sign In And Post`
  String get SignInAndPost {
    return Intl.message(
      'Sign In And Post',
      name: 'SignInAndPost',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get AccountSettings {
    return Intl.message(
      'Account Settings',
      name: 'AccountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Notification Preferences`
  String get NotificationPreferences {
    return Intl.message(
      'Notification Preferences',
      name: 'NotificationPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message('Language', name: 'Language', desc: '', args: []);
  }

  /// `Blog`
  String get Blog {
    return Intl.message('Blog', name: 'Blog', desc: '', args: []);
  }

  /// `Support`
  String get Support {
    return Intl.message('Support', name: 'Support', desc: '', args: []);
  }

  /// `Contact Us`
  String get ContactUs {
    return Intl.message('Contact Us', name: 'ContactUs', desc: '', args: []);
  }

  /// `Advertise On App`
  String get AdvertiseOnApp {
    return Intl.message(
      'Advertise On App',
      name: 'AdvertiseOnApp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get SignOut {
    return Intl.message('Sign Out', name: 'SignOut', desc: '', args: []);
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message('Sign In', name: 'SignIn', desc: '', args: []);
  }

  /// `Vehicles`
  String get Vehicles {
    return Intl.message('Vehicles', name: 'Vehicles', desc: '', args: []);
  }

  /// `Property For Sale`
  String get PropertyForSale {
    return Intl.message(
      'Property For Sale',
      name: 'PropertyForSale',
      desc: '',
      args: [],
    );
  }

  /// `Property For Rent`
  String get PropertyForRent {
    return Intl.message(
      'Property For Rent',
      name: 'PropertyForRent',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out From App!!`
  String get SignOutFromApp {
    return Intl.message(
      'Sign Out From App!!',
      name: 'SignOutFromApp',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out??`
  String get AreYouSureSignOut {
    return Intl.message(
      'Are you sure you want to sign out??',
      name: 'AreYouSureSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get Agree {
    return Intl.message('Agree', name: 'Agree', desc: '', args: []);
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message('Cancel', name: 'Cancel', desc: '', args: []);
  }

  /// `Search Filters`
  String get SearchFilters {
    return Intl.message(
      'Search Filters',
      name: 'SearchFilters',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get Reset {
    return Intl.message('Reset', name: 'Reset', desc: '', args: []);
  }

  /// `Rent`
  String get Rent {
    return Intl.message('Rent', name: 'Rent', desc: '', args: []);
  }

  /// `Sale`
  String get Sale {
    return Intl.message('Sale', name: 'Sale', desc: '', args: []);
  }

  /// `Location`
  String get Location {
    return Intl.message('Location', name: 'Location', desc: '', args: []);
  }

  /// `Select the cities or regions you want to search for property in`
  String get SelectCityOrRegion {
    return Intl.message(
      'Select the cities or regions you want to search for property in',
      name: 'SelectCityOrRegion',
      desc: '',
      args: [],
    );
  }

  /// `Property Type`
  String get PropertyType {
    return Intl.message(
      'Property Type',
      name: 'PropertyType',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get Apartment {
    return Intl.message('Apartment', name: 'Apartment', desc: '', args: []);
  }

  /// `Shop`
  String get Shop {
    return Intl.message('Shop', name: 'Shop', desc: '', args: []);
  }

  /// `Office`
  String get Office {
    return Intl.message('Office', name: 'Office', desc: '', args: []);
  }

  /// `Land`
  String get Land {
    return Intl.message('Land', name: 'Land', desc: '', args: []);
  }

  /// `Villa`
  String get Villa {
    return Intl.message('Villa', name: 'Villa', desc: '', args: []);
  }

  /// `Building`
  String get Building {
    return Intl.message('Building', name: 'Building', desc: '', args: []);
  }

  /// `Factory`
  String get Factory {
    return Intl.message('Factory', name: 'Factory', desc: '', args: []);
  }

  /// `Room`
  String get Room {
    return Intl.message('Room', name: 'Room', desc: '', args: []);
  }

  /// `Number of Bedrooms`
  String get NumberOfBedrooms {
    return Intl.message(
      'Number of Bedrooms',
      name: 'NumberOfBedrooms',
      desc: '',
      args: [],
    );
  }

  /// `Number of Bathrooms`
  String get NumberOfBathrooms {
    return Intl.message(
      'Number of Bathrooms',
      name: 'NumberOfBathrooms',
      desc: '',
      args: [],
    );
  }

  /// `Furnished / Unfurnished`
  String get FurnishedOrUnfurnished {
    return Intl.message(
      'Furnished / Unfurnished',
      name: 'FurnishedOrUnfurnished',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message('All', name: 'All', desc: '', args: []);
  }

  /// `Furnished`
  String get Furnished {
    return Intl.message('Furnished', name: 'Furnished', desc: '', args: []);
  }

  /// `Unfurnished`
  String get Unfurnished {
    return Intl.message('Unfurnished', name: 'Unfurnished', desc: '', args: []);
  }

  /// `Posted By`
  String get PostedBy {
    return Intl.message('Posted By', name: 'PostedBy', desc: '', args: []);
  }

  /// `All`
  String get AllBy {
    return Intl.message('All', name: 'AllBy', desc: '', args: []);
  }

  /// `Owner`
  String get Owner {
    return Intl.message('Owner', name: 'Owner', desc: '', args: []);
  }

  /// `Agent`
  String get Agent {
    return Intl.message('Agent', name: 'Agent', desc: '', args: []);
  }

  /// `Price`
  String get Price {
    return Intl.message('Price', name: 'Price', desc: '', args: []);
  }

  /// `To`
  String get To {
    return Intl.message('To', name: 'To', desc: '', args: []);
  }

  /// `Area`
  String get Area {
    return Intl.message('Area', name: 'Area', desc: '', args: []);
  }

  /// `Square Meters`
  String get SquareMeters {
    return Intl.message(
      'Square Meters',
      name: 'SquareMeters',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get Apply {
    return Intl.message('Apply', name: 'Apply', desc: '', args: []);
  }

  /// `Currency Conversion`
  String get CurrencyConversion {
    return Intl.message(
      'Currency Conversion',
      name: 'CurrencyConversion',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get SelectLanguage {
    return Intl.message(
      'Select Language',
      name: 'SelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message('Arabic', name: 'Arabic', desc: '', args: []);
  }

  /// `English`
  String get English {
    return Intl.message('English', name: 'English', desc: '', args: []);
  }

  /// `Turkish`
  String get Turkish {
    return Intl.message('Turkish', name: 'Turkish', desc: '', args: []);
  }

  /// `Select Currency`
  String get SelectCurrency {
    return Intl.message(
      'Select Currency',
      name: 'SelectCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Syrian Pound`
  String get SyrianPound {
    return Intl.message(
      'Syrian Pound',
      name: 'SyrianPound',
      desc: '',
      args: [],
    );
  }

  /// `US Dollar`
  String get USDollar {
    return Intl.message('US Dollar', name: 'USDollar', desc: '', args: []);
  }

  /// `Turkish Lira`
  String get TurkishLira {
    return Intl.message(
      'Turkish Lira',
      name: 'TurkishLira',
      desc: '',
      args: [],
    );
  }

  /// `Most Visited in Rentals`
  String get MostVisitedInRentals {
    return Intl.message(
      'Most Visited in Rentals',
      name: 'MostVisitedInRentals',
      desc: '',
      args: [],
    );
  }

  /// `Most Visited in Sales`
  String get MostVisitedInSales {
    return Intl.message(
      'Most Visited in Sales',
      name: 'MostVisitedInSales',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get ViewAll {
    return Intl.message('View All', name: 'ViewAll', desc: '', args: []);
  }

  /// `Find Your Home Here`
  String get FindHome {
    return Intl.message(
      'Find Your Home Here',
      name: 'FindHome',
      desc: '',
      args: [],
    );
  }

  /// `Find Your Car Here`
  String get FindCar {
    return Intl.message(
      'Find Your Car Here',
      name: 'FindCar',
      desc: '',
      args: [],
    );
  }

  /// `Find Your Office Here`
  String get FindOffice {
    return Intl.message(
      'Find Your Office Here',
      name: 'FindOffice',
      desc: '',
      args: [],
    );
  }

  /// `Find Your Land Here`
  String get FindLand {
    return Intl.message(
      'Find Your Land Here',
      name: 'FindLand',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Ad`
  String get AddYourAd {
    return Intl.message('Add Your Ad', name: 'AddYourAd', desc: '', args: []);
  }

  /// `Your ad will be reviewed by the Emtelek team and approved within less than 5 minutes if it complies with the publishing rules, then it will be published on the app.`
  String get AdReviewMessage {
    return Intl.message(
      'Your ad will be reviewed by the Emtelek team and approved within less than 5 minutes if it complies with the publishing rules, then it will be published on the app.',
      name: 'AdReviewMessage',
      desc: '',
      args: [],
    );
  }

  /// `The ad information must`
  String get AdInfoNote {
    return Intl.message(
      'The ad information must',
      name: 'AdInfoNote',
      desc: '',
      args: [],
    );
  }

  /// `be relevant to the ad itself to avoid rejection.`
  String get AdRejectionReason {
    return Intl.message(
      'be relevant to the ad itself to avoid rejection.',
      name: 'AdRejectionReason',
      desc: '',
      args: [],
    );
  }

  /// `Do you have any questions? Please check`
  String get QuestionsPrompt {
    return Intl.message(
      'Do you have any questions? Please check',
      name: 'QuestionsPrompt',
      desc: '',
      args: [],
    );
  }

  /// `the publishing guidelines`
  String get PublishingGuidelines {
    return Intl.message(
      'the publishing guidelines',
      name: 'PublishingGuidelines',
      desc: '',
      args: [],
    );
  }

  /// `or contact the Emtelek team directly via`
  String get DirectContactMessage {
    return Intl.message(
      'or contact the Emtelek team directly via',
      name: 'DirectContactMessage',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp.`
  String get WhatsAppContact {
    return Intl.message(
      'WhatsApp.',
      name: 'WhatsAppContact',
      desc: '',
      args: [],
    );
  }

  /// `Enter the details of the ad`
  String get EnterAdDetails {
    return Intl.message(
      'Enter the details of the ad',
      name: 'EnterAdDetails',
      desc: '',
      args: [],
    );
  }

  /// `Ad Title`
  String get AdTitleHint {
    return Intl.message('Ad Title', name: 'AdTitleHint', desc: '', args: []);
  }

  /// `Add Photos`
  String get AddPhotos {
    return Intl.message('Add Photos', name: 'AddPhotos', desc: '', args: []);
  }

  /// `USD`
  String get USD {
    return Intl.message('USD', name: 'USD', desc: '', args: []);
  }

  /// `Total Area`
  String get TotalArea {
    return Intl.message('Total Area', name: 'TotalArea', desc: '', args: []);
  }

  /// `Net Area (Optional)`
  String get NetAreaOptional {
    return Intl.message(
      'Net Area (Optional)',
      name: 'NetAreaOptional',
      desc: '',
      args: [],
    );
  }

  /// `Building Area (Optional)`
  String get BuildingAreaOptional {
    return Intl.message(
      'Building Area (Optional)',
      name: 'BuildingAreaOptional',
      desc: '',
      args: [],
    );
  }

  /// `Ad Description (Optional)`
  String get AdDescriptionOptional {
    return Intl.message(
      'Ad Description (Optional)',
      name: 'AdDescriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Number of Rooms`
  String get NumberOfRooms {
    return Intl.message(
      'Number of Rooms',
      name: 'NumberOfRooms',
      desc: '',
      args: [],
    );
  }

  /// `Floor Number (Optional)`
  String get FloorNumberOptional {
    return Intl.message(
      'Floor Number (Optional)',
      name: 'FloorNumberOptional',
      desc: '',
      args: [],
    );
  }

  /// `Floor Count (Optional)`
  String get FloorCountOptional {
    return Intl.message(
      'Floor Count (Optional)',
      name: 'FloorCountOptional',
      desc: '',
      args: [],
    );
  }

  /// `Number of Balconies (Optional)`
  String get NumberOfBalconiesOptional {
    return Intl.message(
      'Number of Balconies (Optional)',
      name: 'NumberOfBalconiesOptional',
      desc: '',
      args: [],
    );
  }

  /// `Construction Date (Optional)`
  String get ConstructionDateOptional {
    return Intl.message(
      'Construction Date (Optional)',
      name: 'ConstructionDateOptional',
      desc: '',
      args: [],
    );
  }

  /// `Furnished (Optional)`
  String get FurnishedOptional {
    return Intl.message(
      'Furnished (Optional)',
      name: 'FurnishedOptional',
      desc: '',
      args: [],
    );
  }

  /// `Net Area`
  String get NetArea {
    return Intl.message('Net Area', name: 'NetArea', desc: '', args: []);
  }

  /// `Building Area`
  String get BuildingArea {
    return Intl.message(
      'Building Area',
      name: 'BuildingArea',
      desc: '',
      args: [],
    );
  }

  /// `Ad Description`
  String get AdDescription {
    return Intl.message(
      'Ad Description',
      name: 'AdDescription',
      desc: '',
      args: [],
    );
  }

  /// `Floor Number`
  String get FloorNumber {
    return Intl.message(
      'Floor Number',
      name: 'FloorNumber',
      desc: '',
      args: [],
    );
  }

  /// `Floor Count`
  String get FloorCount {
    return Intl.message('Floor Count', name: 'FloorCount', desc: '', args: []);
  }

  /// `Number of Balconies`
  String get NumberOfBalconies {
    return Intl.message(
      'Number of Balconies',
      name: 'NumberOfBalconies',
      desc: '',
      args: [],
    );
  }

  /// `Construction Date`
  String get ConstructionDate {
    return Intl.message(
      'Construction Date',
      name: 'ConstructionDate',
      desc: '',
      args: [],
    );
  }

  /// `Property Owner`
  String get PropertyOwner {
    return Intl.message(
      'Property Owner',
      name: 'PropertyOwner',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get City {
    return Intl.message('City', name: 'City', desc: '', args: []);
  }

  /// `Region`
  String get Region {
    return Intl.message('Region', name: 'Region', desc: '', args: []);
  }

  /// `Neighborhood and Street, e.g., Abou Roumaneh District - Al Jalaa Street (Optional)`
  String get NeighborhoodAndStreetOptional {
    return Intl.message(
      'Neighborhood and Street, e.g., Abou Roumaneh District - Al Jalaa Street (Optional)',
      name: 'NeighborhoodAndStreetOptional',
      desc: '',
      args: [],
    );
  }

  /// `Neighborhood and Street`
  String get NeighborhoodAndStreet {
    return Intl.message(
      'Neighborhood and Street',
      name: 'NeighborhoodAndStreet',
      desc: '',
      args: [],
    );
  }

  /// `Building or Complex Name (Optional)`
  String get BuildingOrComplexNameOptional {
    return Intl.message(
      'Building or Complex Name (Optional)',
      name: 'BuildingOrComplexNameOptional',
      desc: '',
      args: [],
    );
  }

  /// `Building or Complex Name`
  String get BuildingOrComplexName {
    return Intl.message(
      'Building or Complex Name',
      name: 'BuildingOrComplexName',
      desc: '',
      args: [],
    );
  }

  /// `What would you like to advertise?`
  String get WhatWouldYouLikeToAdvertise {
    return Intl.message(
      'What would you like to advertise?',
      name: 'WhatWouldYouLikeToAdvertise',
      desc: '',
      args: [],
    );
  }

  /// `Choose the appropriate category for your ad`
  String get ChooseTheAppropriateCategoryForYourAd {
    return Intl.message(
      'Choose the appropriate category for your ad',
      name: 'ChooseTheAppropriateCategoryForYourAd',
      desc: '',
      args: [],
    );
  }

  /// `Now, choose the appropriate category for your ad:`
  String get ChooseTheRightCategory {
    return Intl.message(
      'Now, choose the appropriate category for your ad:',
      name: 'ChooseTheRightCategory',
      desc: '',
      args: [],
    );
  }

  /// `Bathroom`
  String get Bathroom {
    return Intl.message('Bathroom', name: 'Bathroom', desc: '', args: []);
  }

  /// `Type`
  String get Type {
    return Intl.message('Type', name: 'Type', desc: '', args: []);
  }

  /// `Description`
  String get Description {
    return Intl.message('Description', name: 'Description', desc: '', args: []);
  }

  /// `Ad Title`
  String get AdTitle {
    return Intl.message('Ad Title', name: 'AdTitle', desc: '', args: []);
  }

  /// `Added`
  String get Added {
    return Intl.message('Added', name: 'Added', desc: '', args: []);
  }

  /// `Photo`
  String get Photo {
    return Intl.message('Photo', name: 'Photo', desc: '', args: []);
  }

  /// `m²`
  String get SquareMeter {
    return Intl.message('m²', name: 'SquareMeter', desc: '', args: []);
  }

  /// `Select location from map`
  String get SelectLocationFromMap {
    return Intl.message(
      'Select location from map',
      name: 'SelectLocationFromMap',
      desc: '',
      args: [],
    );
  }

  /// `Search for the location`
  String get SearchForTheLocation {
    return Intl.message(
      'Search for the location',
      name: 'SearchForTheLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add location`
  String get AddLocation {
    return Intl.message(
      'Add location',
      name: 'AddLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add photo`
  String get AddPhoto {
    return Intl.message('Add photo', name: 'AddPhoto', desc: '', args: []);
  }

  /// `Select photo`
  String get SelectPhoto {
    return Intl.message(
      'Select photo',
      name: 'SelectPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Main photo`
  String get MainPhoto {
    return Intl.message('Main photo', name: 'MainPhoto', desc: '', args: []);
  }

  /// `Set as main photo`
  String get SetAsMainPhoto {
    return Intl.message(
      'Set as main photo',
      name: 'SetAsMainPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Set`
  String get Set {
    return Intl.message('Set', name: 'Set', desc: '', args: []);
  }

  /// `Ad Preview`
  String get AdPreview {
    return Intl.message('Ad Preview', name: 'AdPreview', desc: '', args: []);
  }

  /// `undefined`
  String get undefined {
    return Intl.message('undefined', name: 'undefined', desc: '', args: []);
  }

  /// `Currency`
  String get Currency {
    return Intl.message('Currency', name: 'Currency', desc: '', args: []);
  }

  /// `Save Search`
  String get SaveSearch {
    return Intl.message('Save Search', name: 'SaveSearch', desc: '', args: []);
  }

  /// `Features (Optional)`
  String get FeaturesOptional {
    return Intl.message(
      'Features (Optional)',
      name: 'FeaturesOptional',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
