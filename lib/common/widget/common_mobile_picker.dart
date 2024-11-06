import 'package:flutter/material.dart';

class Country {
  final String name;
  final String flag;
  final String code;

  Country({
    required this.name,
    required this.flag,
    required this.code,
  });
}

class MobilePicker extends StatefulWidget {
  final Function(Country) onSelect;

  const MobilePicker({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<MobilePicker> createState() => _MobilePickerState();
}

class _MobilePickerState extends State<MobilePicker> {
  final List<Country> countries = [
    Country(name: 'India', flag: '🇮🇳', code: '+91'),
    Country(name: 'Australia', flag: '🇦🇺', code: '+61'),
    Country(name: 'Sri Lanka', flag: '🇱🇰', code: '+94'),
    Country(name: 'Pakistan', flag: '🇵🇰', code: '+92'),
    Country(name: 'Nigeria', flag: '🇳🇬', code: '+234'),
    Country(name: 'China', flag: '🇨🇳', code: '+86'),
  ];

  int? selectedIndex;
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  List<Country> get filteredCountries {
    if (searchQuery.isEmpty) return countries;
    return countries
        .where((country) =>
            country.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Your Country',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Mobile Code, Country',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    filteredCountries.length,
                    (index) => RadioListTile<int>(
                      value: index,
                      groupValue: selectedIndex,
                      onChanged: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                      title: Row(
                        children: [
                          Text(
                            filteredCountries[index].flag,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            filteredCountries[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedIndex == null
                    ? null
                    : () {
                        widget.onSelect(filteredCountries[selectedIndex!]);
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
