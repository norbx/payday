CATEGORIES_COMBINED = {
  "Codzienne wydatki" => [
    "Alkohol",
    "Jedzenie poza domem",
    "Papierosy",
    "Zwierzęta",
    "Żywność i chemia domowa",
    "Codzienne wydatki - inne"
  ],
  "Wpływy" => [
    "Odsetki",
    "Premia",
    "Wynagrodzenie",
    "Wypłata kredytu",
    "Wpływy - inne"
  ],
  "Oszczędności inwestycyjne" => [
    "Fundusze",
    "Giełda",
    "Lokaty i konto oszcz.",
    "Regularne oszczędzanie",
    "Oszczędności inw. - inne"
  ],
  "Nieistotne" => [
    "Przelew własny",
    "Spłąta karty kredytowej",
    "Nieistotne - inne"
  ],
  "Rozrywka" => [
    "Podróże i wyjazdy",
    "Sport i hobby",
    "Wyjścia i wydarzenia",
    "Rozrywka - inne"
  ],
  "Płatności" => [
    "Czynsz i wynajem",
    "Gaz",
    "Ogrzewanie",
    "Opłaty i odsetki",
    "Podatki",
    "Prąd",
    "Spłaty rat",
    "TV, internet, telefon",
    "Ubezpieczenia",
    "Woda i kanalizacja",
    "Płatności - inne"
  ],
  "Nieskategoryzowane" => [
    "Wypłata gotówki",
    "Bez kategorii"
  ],
  "Auto i transport" => [
    "Paliwo",
    "Parking i opłaty",
    "Przejazdy",
    "Serwis i części",
    "Ubezpieczenie auta",
    "Auto i transport - inne"
  ],
  "Osobiste" => [
    "Edukacja",
    "Elektronika",
    "Multimedia, książki i prasa",
    "Odzież i obuwie",
    "Prezenty i wsparcie",
    "Zdrowie i uroda",
    "Osobiste - inne"
  ],
  "Dom" => [
    "Akcesoria i wyposażenie",
    "Remont i ogród",
    "Ubezpieczenie domu",
    "Usługi domowe",
    "Dom - inne"
  ],
  "Dzieci" => [
    "Art. dziecięce i zabawki",
    "Przedszkole i opiekunka",
    "Szkoła i wyprawka",
    "Zajęcia dodatkowe",
    "Dzieci - inne"
  ],
  "Firmowe" => [
    "Przelew na rach. firmowy",
    "Zakupy firmowe",
    "Firmowe - inne"
  ],
  "Oszczędności i inw." => [
    "Fundusze",
    "Giełda",
    "Lokaty i konto oszcz.",
    "Regularne oszczędzanie",
    "Oszczędności i inw. - inne"
  ]
}

desc "Setup environment, import initial categories and subcategories to the database"
task setup_categories: :environment do
  CATEGORIES_COMBINED.each_pair do |category_name, subcategories|
    category = Category.find_or_create_by!(name: category_name)

    subcategories.each do |subcategory_name|
      Subcategory.find_or_create_by!(name: subcategory_name, category:)
    end
  end
end
