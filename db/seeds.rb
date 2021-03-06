Category.find_or_create_by(name: 'bonus')
Category.find_or_create_by(name: 'codzienne')
Category.find_or_create_by(name: 'transport')
Category.find_or_create_by(name: 'rozrywka')
Category.find_or_create_by(name: 'miasto')
Category.find_or_create_by(name: 'firma')
Category.find_or_create_by(name: 'zakupy')
Category.find_or_create_by(name: 'rachunki')
Category.find_or_create_by(name: 'czynsz')
Category.find_or_create_by(name: 'wynagrodzenie')
Category.find_or_create_by(name: 'inne')
Category.find_or_create_by(name: 'zus')
Category.find_or_create_by(name: 'wyjazdy')
Category.find_or_create_by(name: 'oszczednosci')

Expense.find_or_create_by(
  transaction_date: Date.current,
  amount: 10.00,
  description: 'Tytuł: 010061097 74169501002520032452405',
  localization: 'Lokalizacja: Kraj: POLSKA Miasto: WARSZAWA Adres: CARREFOUR SUPERMARKET',
  referential_number: 'Numer referencyjny: 00000056348396455',
  category: Category.first
)
Expense.find_or_create_by(
  transaction_date: Date.current,
  amount: 15.00,
  description: 'Tytuł: 010061097 74169501002520032452405',
  localization: 'Lokalizacja: Kraj: POLSKA Miasto: WARSZAWA Adres: CARREFOUR SUPERMARKET',
  referential_number: 'Numer referencyjny: 00000056348396455',
  category: Category.first
)
Expense.find_or_create_by(
  transaction_date: 1.day.ago,
  amount: 5.38,
  description: 'Tytuł: 010061097 74169501002520032452405',
  localization: 'Lokalizacja: Kraj: POLSKA Miasto: WARSZAWA Adres: CARREFOUR SUPERMARKET',
  referential_number: 'Numer referencyjny: 00000056348396455',
  category: Category.second
)
Expense.find_or_create_by(
  transaction_date: 1.day.from_now,
  amount: 150.00,
  description: 'Tytuł: 010061097 74169501002520032452405',
  localization: 'Lokalizacja: Kraj: POLSKA Miasto: WARSZAWA Adres: CARREFOUR SUPERMARKET',
  referential_number: 'Numer referencyjny: 00000056348396455',
  category: Category.third
)
