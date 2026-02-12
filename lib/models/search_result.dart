class CardModel {
  final String id;
  final String name;
  final String? supertype;       // Pokémon, Trainer, Energy
  final List<String>? subtypes;  // Basic, Stage 1, Stage 2...
  final String? hp;
  final List<String>? types;     // Fire, Water, Grass...
  final String? evolvesFrom;
  final List<Attack>? attacks;
  final List<Weakness>? weaknesses;
  final List<Resistance>? resistances;
  final List<String>? retreatCost;
  final CardSet? set;
  final String? number;
  final String? artist;
  final String? rarity;
  final CardImages? images;
  final Legalities? legalities;

  CardModel({
    required this.id,
    required this.name,
    this.supertype,
    this.subtypes,
    this.hp,
    this.types,
    this.evolvesFrom,
    this.attacks,
    this.weaknesses,
    this.resistances,
    this.retreatCost,
    this.set,
    this.number,
    this.artist,
    this.rarity,
    this.images,
    this.legalities,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      supertype: json['supertype'],
      subtypes: json['subtypes'] != null
          ? List<String>.from(json['subtypes'])
          : null,
      hp: json['hp'],
      types: json['types'] != null
          ? List<String>.from(json['types'])
          : null,
      evolvesFrom: json['evolvesFrom'],
      attacks: json['attacks'] != null
          ? (json['attacks'] as List)
              .map((a) => Attack.fromJson(a))
              .toList()
          : null,
      weaknesses: json['weaknesses'] != null
          ? (json['weaknesses'] as List)
              .map((w) => Weakness.fromJson(w))
              .toList()
          : null,
      resistances: json['resistances'] != null
          ? (json['resistances'] as List)
              .map((r) => Resistance.fromJson(r))
              .toList()
          : null,
      retreatCost: json['retreatCost'] != null
          ? List<String>.from(json['retreatCost'])
          : null,
      set: json['set'] != null ? CardSet.fromJson(json['set']) : null,
      number: json['number'],
      artist: json['artist'],
      rarity: json['rarity'],
      images:
          json['images'] != null ? CardImages.fromJson(json['images']) : null,
      legalities: json['legalities'] != null
          ? Legalities.fromJson(json['legalities'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'supertype': supertype,
      'subtypes': subtypes,
      'hp': hp,
      'types': types,
      'evolvesFrom': evolvesFrom,
      'attacks': attacks?.map((a) => a.toJson()).toList(),
      'weaknesses': weaknesses?.map((w) => w.toJson()).toList(),
      'resistances': resistances?.map((r) => r.toJson()).toList(),
      'retreatCost': retreatCost,
      'set': set?.toJson(),
      'number': number,
      'artist': artist,
      'rarity': rarity,
      'images': images?.toJson(),
      'legalities': legalities?.toJson(),
    };
  }
}

// ─────────────────────────────────────────
// Attaque
// ─────────────────────────────────────────
class Attack {
  final String name;
  final List<String> cost;
  final String convertedEnergyCost;
  final String? damage;
  final String? text;

  Attack({
    required this.name,
    required this.cost,
    required this.convertedEnergyCost,
    this.damage,
    this.text,
  });

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      name: json['name'] ?? '',
      cost: List<String>.from(json['cost'] ?? []),
      convertedEnergyCost: json['convertedEnergyCost']?.toString() ?? '0',
      damage: json['damage'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'cost': cost,
        'convertedEnergyCost': convertedEnergyCost,
        'damage': damage,
        'text': text,
      };
}

// ─────────────────────────────────────────
// Faiblesse
// ─────────────────────────────────────────
class Weakness {
  final String type;
  final String value;

  Weakness({required this.type, required this.value});

  factory Weakness.fromJson(Map<String, dynamic> json) {
    return Weakness(
      type: json['type'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'type': type, 'value': value};
}

// ─────────────────────────────────────────
// Résistance
// ─────────────────────────────────────────
class Resistance {
  final String type;
  final String value;

  Resistance({required this.type, required this.value});

  factory Resistance.fromJson(Map<String, dynamic> json) {
    return Resistance(
      type: json['type'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'type': type, 'value': value};
}

// ─────────────────────────────────────────
// Set (extension)
// ─────────────────────────────────────────
class CardSet {
  final String id;
  final String name;
  final String? series;
  final int? printedTotal;
  final int? total;
  final String? releaseDate;
  final SetImages? images;

  CardSet({
    required this.id,
    required this.name,
    this.series,
    this.printedTotal,
    this.total,
    this.releaseDate,
    this.images,
  });

  factory CardSet.fromJson(Map<String, dynamic> json) {
    return CardSet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      series: json['series'],
      printedTotal: json['printedTotal'],
      total: json['total'],
      releaseDate: json['releaseDate'],
      images: json['images'] != null ? SetImages.fromJson(json['images']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'series': series,
        'printedTotal': printedTotal,
        'total': total,
        'releaseDate': releaseDate,
        'images': images?.toJson(),
      };
}

// ─────────────────────────────────────────
// Images de la carte
// ─────────────────────────────────────────
class CardImages {
  final String? small;
  final String? large;

  CardImages({this.small, this.large});

  factory CardImages.fromJson(Map<String, dynamic> json) {
    return CardImages(
      small: json['small'],
      large: json['large'],
    );
  }

  Map<String, dynamic> toJson() => {'small': small, 'large': large};
}

// ─────────────────────────────────────────
// Images du set
// ─────────────────────────────────────────
class SetImages {
  final String? symbol;
  final String? logo;

  SetImages({this.symbol, this.logo});

  factory SetImages.fromJson(Map<String, dynamic> json) {
    return SetImages(
      symbol: json['symbol'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() => {'symbol': symbol, 'logo': logo};
}

// ─────────────────────────────────────────
// Légalités (formats de tournoi)
// ─────────────────────────────────────────
class Legalities {
  final String? unlimited;
  final String? standard;
  final String? expanded;

  Legalities({this.unlimited, this.standard, this.expanded});

  factory Legalities.fromJson(Map<String, dynamic> json) {
    return Legalities(
      unlimited: json['unlimited'],
      standard: json['standard'],
      expanded: json['expanded'],
    );
  }

  Map<String, dynamic> toJson() => {
        'unlimited': unlimited,
        'standard': standard,
        'expanded': expanded,
      };
}