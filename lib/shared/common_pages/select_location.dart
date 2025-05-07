import 'package:emtelek/core/constants/app_colors.dart';
import 'package:emtelek/core/extensions/media_query_extensions.dart';
import 'package:emtelek/core/utils/snackbar_utils.dart';
import 'package:emtelek/features/add_listing/domain/cubit/property_add_ad_cubit.dart';
import 'package:emtelek/features/my_ads/domain/cubit/my_ads_cubit.dart';
import 'package:emtelek/shared/cubits/settings_cubit/settings_cubit.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation(
      {super.key, required this.forWitchFeature, required this.isEdit});
  final int forWitchFeature; // 1--> Property 2--> Cars
  // final LatLng? selectedLocation;
  final bool isEdit;
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  LatLng? selectedLocation;
  LatLng currentLocation = LatLng(33.5125, 36.2785); // دمشق (كموقع افتراضي)
  final TextEditingController searchController = TextEditingController();
  final String apiKey = "fc28ab505f784d2a85d47786c93e4801";
  final MapController _mapController =
      MapController(); // إضافة المتحكم في الخريطة

  // دالة البحث وإرجاع الاقتراحات
  Future<List<String>> _searchSuggestions(String query) async {
    final url =
        "https://api.opencagedata.com/geocode/v1/json?q=$query&key=$apiKey&language=${getIt<CacheHelper>().getDataString(key: 'Lang')}";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    // إرجاع قائمة من السلاسل النصية فقط
    if (data['results'] != null && data['results'].isNotEmpty) {
      return data['results']
          .map<String>((result) => result['formatted'] as String)
          .toList();
    }
    return []; // إرجاع قائمة فارغة إذا لم يكن هناك نتائج
  }

  // دالة تغيير الموقع عند اختيار الاقتراح
  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;

    final url =
        "https://api.opencagedata.com/geocode/v1/json?q=$query&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final result = data['results'][0]['geometry'];
          final LatLng newLocation = LatLng(result['lat'], result['lng']);
          setState(() {
            currentLocation = newLocation;
            selectedLocation = newLocation;
          });
          _mapController.move(newLocation, 14.0); // تحريك الخريطة إلى الموقع
        }
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في البحث عن الموقع')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // تعيين currentLocation بناءً على حالة isEdit
    if (widget.isEdit) {
      final myAdsCubit = BlocProvider.of<MyAdsCubit>(context);
      final settingsCubit = BlocProvider.of<SettingsCubit>(context);

      // قم بفحص إذا كان `location` غير فارغ قبل محاولة تحليله
      if (myAdsCubit.myAds[myAdsCubit.editIndex].location != null) {
        currentLocation = settingsCubit.parseLatLng(
          myAdsCubit.myAds[myAdsCubit.editIndex].location!,
        );
        selectedLocation =
            currentLocation; // تعيين الموقع المحدد كالموقع الحالي
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PropertyAddAdCubit propertyAddAdCubit =
        BlocProvider.of<PropertyAddAdCubit>(context);
    MyAdsCubit myAdsCubit = BlocProvider.of<MyAdsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: TextWidget(
                text: 'أضف اعلانك',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController:
                _mapController, // تأكيد أن الخريطة تستخدم هذا المتحكم
            options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: 14.0,
              onTap: (_, point) {
                setState(() {
                  selectedLocation = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              if (selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on, color: Colors.red),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 8,
            left: 0, // تمديد العنصر بعرض الشاشة
            right: 0,
            child: Align(
              alignment: Alignment.topCenter, // التوسيط الأفقي
              child: SizedBox(
                width: context.width * 0.95,
                height: context.height * 0.06,
                child: TypeAheadField<String>(
                  suggestionsCallback: (pattern) async {
                    return await _searchSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ), // تغيير لون النص
                      ),
                    );
                  },
                  onSelected: (suggestion) {
                    searchController.text = suggestion;
                    _searchLocation(suggestion);
                  },
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: controller,
                      cursorColor: AppColors.primary,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        labelText: "ابحث عن الموقع",
                        filled: true, // تفعيل تعبئة الخلفية
                        fillColor: Colors.white, // تغيير لون الخلفية
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2.5,
                          ),
                        ),
                      ),
                    );
                  },
                  decorationBuilder: (context, child) {
                    return Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      child: child,
                    );
                  },
                  emptyBuilder: (context) => const SizedBox.shrink(),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (widget.forWitchFeature == 1) {
            if (selectedLocation != null) {
              if (widget.isEdit == false) {
                propertyAddAdCubit.setPropertyField('adModelLocation',
                    "${selectedLocation!.latitude},${selectedLocation!.longitude}");
              } else {
                myAdsCubit.updatePropertyField('adModelLocation',
                    "${selectedLocation!.latitude},${selectedLocation!.longitude}");
              }
              print(selectedLocation);
              Navigator.pop(context);
            } else {
              SnackbarUtils.showSnackbar(context, "يرجى تحديد الموقع");
            }
          } else if (widget.forWitchFeature == 2) {} // for cars
        },
        child: const Icon(Icons.check, color: Colors.black, size: 32),
      ),
    );
  }
}

/*

 Expanded(
            child: FlutterMap(
              mapController:
                  _mapController, // تأكيد أن الخريطة تستخدم هذا المتحكم
              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 14.0,
                onTap: (_, point) {
                  setState(() {
                    selectedLocation = point;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                if (selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: selectedLocation!,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.location_on, color: Colors.red),
                      ),
                    ],
                  ),
              ],
            ),
          ),


*/
