class Reader
  class << self
    def read_csv(file_path)
      CSV.read(file_path, headers: headers, encoding: 'ISO8859-1')
    end

    private

    attr_reader :file_path

    def headers
      [
        'Data operacji', 'Data waluty', 'Typ transakcji', 'Kwota', 'Waluta',
        'Saldo po transakcji', 'Opis transakcji', 'Lokalizacja',
        'Data i czas transakcji', 'Oryginalna kwota operacji', 'Numer operacji'
      ]
    end
  end
end
