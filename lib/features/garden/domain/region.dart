/// Growing regions used for sowing windows (ADR-015).
///
/// Only regions with sourced sowing data exist here
/// (gardening-references §2c: ICAR North/South India tables, plus state
/// tables for Telangana, Tamil Nadu and Kerala; since 2026-10-30 western
/// Maharashtra, Gujarat, Goa and Assam). Cities outside these have no region
/// yet; recommendations then report the season fit as unknown rather than
/// guessing.
enum GrowingRegion {
  northIndia,
  southIndia,
  telangana,
  tamilNadu,
  kerala,

  /// The western Maharashtra plains (Pune, Nashik and around), which MPKV
  /// Rahuri's calendar covers; not Konkan or Vidarbha.
  westernMaharashtra,
  gujarat,
  goa,
  assam,
}

extension GrowingRegionX on GrowingRegion {
  /// The macro region whose data applies when state-level data is missing.
  GrowingRegion get macroRegion => switch (this) {
    GrowingRegion.northIndia => GrowingRegion.northIndia,
    GrowingRegion.southIndia ||
    GrowingRegion.telangana ||
    GrowingRegion.tamilNadu ||
    GrowingRegion.kerala => GrowingRegion.southIndia,
    // No sourced wider calendar covers these yet.
    GrowingRegion.westernMaharashtra => GrowingRegion.westernMaharashtra,
    GrowingRegion.gujarat => GrowingRegion.gujarat,
    GrowingRegion.goa => GrowingRegion.goa,
    GrowingRegion.assam => GrowingRegion.assam,
  };
}

/// A city the user can pick offline.
class City {
  const City(this.name, this.state, this.region);

  final String name;
  final String state;

  /// Null when no sourced sowing data covers the city yet.
  final GrowingRegion? region;
}

/// Offline city list for the location picker. Region assignment follows the
/// sourced tables only; west, central and east Indian cities are listed but
/// have no region until sources cover them (known-issues KI-017).
const indianCities = <City>[
  // Telangana (Telangana Horticulture urban-farming table, S13)
  City('Hyderabad', 'Telangana', GrowingRegion.telangana),
  City('Secunderabad', 'Telangana', GrowingRegion.telangana),
  City('Warangal', 'Telangana', GrowingRegion.telangana),
  // Tamil Nadu (TNAU, S14–S25)
  City('Chennai', 'Tamil Nadu', GrowingRegion.tamilNadu),
  City('Coimbatore', 'Tamil Nadu', GrowingRegion.tamilNadu),
  City('Madurai', 'Tamil Nadu', GrowingRegion.tamilNadu),
  City('Tiruchirappalli', 'Tamil Nadu', GrowingRegion.tamilNadu),
  City('Salem', 'Tamil Nadu', GrowingRegion.tamilNadu),
  // Kerala (KAU, S12)
  City('Thiruvananthapuram', 'Kerala', GrowingRegion.kerala),
  City('Kochi', 'Kerala', GrowingRegion.kerala),
  City('Kozhikode', 'Kerala', GrowingRegion.kerala),
  City('Thrissur', 'Kerala', GrowingRegion.kerala),
  // Other South India (ICAR South India column, S11)
  City('Bengaluru', 'Karnataka', GrowingRegion.southIndia),
  City('Mysuru', 'Karnataka', GrowingRegion.southIndia),
  City('Mangaluru', 'Karnataka', GrowingRegion.southIndia),
  City('Hubballi', 'Karnataka', GrowingRegion.southIndia),
  City('Visakhapatnam', 'Andhra Pradesh', GrowingRegion.southIndia),
  City('Vijayawada', 'Andhra Pradesh', GrowingRegion.southIndia),
  City('Tirupati', 'Andhra Pradesh', GrowingRegion.southIndia),
  City('Puducherry', 'Puducherry', GrowingRegion.southIndia),
  // North India (ICAR North India column, S11)
  City('Delhi', 'Delhi', GrowingRegion.northIndia),
  City('Gurugram', 'Haryana', GrowingRegion.northIndia),
  City('Noida', 'Uttar Pradesh', GrowingRegion.northIndia),
  City('Ghaziabad', 'Uttar Pradesh', GrowingRegion.northIndia),
  City('Faridabad', 'Haryana', GrowingRegion.northIndia),
  City('Chandigarh', 'Chandigarh', GrowingRegion.northIndia),
  City('Ludhiana', 'Punjab', GrowingRegion.northIndia),
  City('Amritsar', 'Punjab', GrowingRegion.northIndia),
  City('Jaipur', 'Rajasthan', GrowingRegion.northIndia),
  City('Lucknow', 'Uttar Pradesh', GrowingRegion.northIndia),
  City('Kanpur', 'Uttar Pradesh', GrowingRegion.northIndia),
  City('Agra', 'Uttar Pradesh', GrowingRegion.northIndia),
  City('Varanasi', 'Uttar Pradesh', GrowingRegion.northIndia),
  City('Patna', 'Bihar', GrowingRegion.northIndia),
  // Not yet covered by a sourced regional table.
  City('Mumbai', 'Maharashtra', null),
  City('Pune', 'Maharashtra', GrowingRegion.westernMaharashtra),
  City('Nagpur', 'Maharashtra', null),
  City('Nashik', 'Maharashtra', GrowingRegion.westernMaharashtra),
  City('Kolhapur', 'Maharashtra', GrowingRegion.westernMaharashtra),
  City('Satara', 'Maharashtra', GrowingRegion.westernMaharashtra),
  City('Sangli', 'Maharashtra', GrowingRegion.westernMaharashtra),
  City('Solapur', 'Maharashtra', GrowingRegion.westernMaharashtra),
  City('Ahilyanagar', 'Maharashtra', GrowingRegion.westernMaharashtra),
  City('Thane', 'Maharashtra', null),
  City('Ahmedabad', 'Gujarat', GrowingRegion.gujarat),
  City('Surat', 'Gujarat', GrowingRegion.gujarat),
  City('Vadodara', 'Gujarat', GrowingRegion.gujarat),
  City('Rajkot', 'Gujarat', GrowingRegion.gujarat),
  City('Gandhinagar', 'Gujarat', GrowingRegion.gujarat),
  City('Bhavnagar', 'Gujarat', GrowingRegion.gujarat),
  City('Indore', 'Madhya Pradesh', null),
  City('Bhopal', 'Madhya Pradesh', null),
  City('Raipur', 'Chhattisgarh', null),
  City('Kolkata', 'West Bengal', null),
  City('Bhubaneswar', 'Odisha', null),
  City('Guwahati', 'Assam', GrowingRegion.assam),
  City('Dibrugarh', 'Assam', GrowingRegion.assam),
  City('Jorhat', 'Assam', GrowingRegion.assam),
  City('Silchar', 'Assam', GrowingRegion.assam),
  City('Goa (Panaji)', 'Goa', GrowingRegion.goa),
  City('Margao', 'Goa', GrowingRegion.goa),
];

/// Case-insensitive search by city or state, ordered by name.
List<City> searchCities(String query) {
  final q = query.trim().toLowerCase();
  final matches = q.isEmpty
      ? [...indianCities]
      : indianCities
            .where(
              (c) =>
                  c.name.toLowerCase().contains(q) ||
                  c.state.toLowerCase().contains(q),
            )
            .toList();
  return matches..sort((a, b) => a.name.compareTo(b.name));
}

City? cityByName(String name) {
  for (final city in indianCities) {
    if (city.name == name) return city;
  }
  return null;
}
